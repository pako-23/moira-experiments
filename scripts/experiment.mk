runs := 1 2 3 4 5 6 7 8 9 10
timeout := 43200

plain_files := $(foreach run,$(runs),run-$(run)/plain.txt)
electric_test_files := $(foreach run,$(runs),run-$(run)/electric-test-conflicts.txt)
tuscan_class_only_files := $(foreach run,$(runs),run-$(run)/tuscan-class-only-conflicts.txt)
tuscan_intra_class_files := $(foreach run,$(runs),run-$(run)/tuscan-intra-class-conflicts.txt)
tuscan_inter_class_files := $(foreach run,$(runs),run-$(run)/tuscan-inter-class-conflicts.txt)
tuscan_packed_files := $(foreach run,$(runs),run-$(run)/tuscan-packed-conflicts.txt)
target_pairs_files := $(foreach run,$(runs),run-$(run)/target-pairs-conflicts.txt)
moira_files := $(foreach run,$(runs),run-$(run)/moira-conflicts.txt)


all: plain electric-test tuscan-class-only tuscan-intra-class tuscan-inter-class \
	tuscan-packed target-pairs moira

plain: $(plain_files)
electric-test: $(electric_test_files)
tuscan-class-only: $(tuscan_class_only_files)
tuscan-intra-class: $(tuscan_intra_class_files)
tuscan-inter-class: $(tuscan_inter_class_files)
tuscan-packed: $(tuscan_packed_files)
target-pairs: $(target_pairs_files)
moira: $(moira_files)


mvn_exec = JAVA_HOME=$(JAVA_HOME) $(MVN_BIN) $(1)

define java_exec
if test $$($(JAVA_HOME)/bin/java -version 2>&1 | head -n 1 | awk -F '"' '{print $$2}' | cut -d. -f1) -ge 9; then \
	timeout $(timeout) $(JAVA_HOME)/bin/java -Xss2m --add-opens java.base/java.util=ALL-UNNAMED --add-exports java.base/sun.security.jca=ALL-UNNAMED $(1); \
else \
	timeout $(timeout) $(JAVA_HOME)/bin/java -Xss2m $(1); \
fi
endef

classpath: testsuite
	$(call mvn_exec,dependency:build-classpath -DincludeScope=test -Dmdep.outputFile=classpath)

testsuite:
	$(call mvn_exec,test) || true
	@find target/ -name 'TEST-*.xml' | sed 's/.*TEST-\(.*\)\.xml/\1/' > testsuite
	@for class in $(TESTSUITE_FILTER); do \
		sed -i "/$$class/d" testsuite; \
	done

# Plain test suite execution targets
%plain.txt: testsuite classpath
	mkdir -p $(dir $@); \
	start_time="$$(date -u +%s)"; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/ \
		org.junit.runner.JUnitCore $$(cat testsuite | tr '\n' ' ')) > $@; \
	echo "plain: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times


# ElectricTest targets setup
maven_test_execution_order cp.txt reference-output.csv test-execution-order enumerations package-filter &: \
	testsuite classpath
	start_time="$$(date -u +%s)" ; \
	find target/ -name 'TEST*.xml' -print0 | xargs -0 grep testcase | grep time | grep name | awk -F'"' '{for (i = 1; i <= NF; i++) {if ($$i ~ /classname=/) {classname=$$(i+1)} else if ($$i ~ /name=/) {name=$$(i+1)}} if (classname && name) {print classname "." name}}' > maven_test_execution_order && \
	$(call mvn_exec,dependency:build-classpath -DincludeScope=test -Dmdep.outputFile=cp.txt) && \
	BIN=$(top_srcdir)/experiments/pradet-replication/bin JAVA_HOME=$(JAVA_HOME) $(top_srcdir)/experiments/pradet-replication/scripts/generate_test_order.sh maven_test_execution_order && \
	BIN=$(top_srcdir)/experiments/pradet-replication/bin JAVA_HOME=$(JAVA_HOME) PATH="$(JAVA_HOME)/bin:$$PATH" $(top_srcdir)/experiments/pradet-replication/scripts/bootstrap_enums.sh && \
	$(top_srcdir)/experiments/pradet-replication/scripts/create_package_filter.sh && \
	echo "electric-test-setup: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times

%electric-test-conflicts.txt: maven_test_execution_order cp.txt reference-output.csv \
	test-execution-order enumerations package-filter
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f electric-test-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		BIN=$(top_srcdir)/experiments/pradet-replication/bin \
		DATADEP_DETECTOR_HOME=$(top_srcdir)/experiments/pradet-replication/datadep-detector \
		JAVA_HOME=$(JAVA_HOME) \
		timeout $(timeout) $(top_srcdir)/experiments/pradet-replication/scripts/collect.sh; \
		if [ $$? -eq 124 ]; then \
			touch electric-test-timed-out; \
		fi; \
		echo "electric-test: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
		sed -E 's/([^,]+)\.([^,]+),([^,]+)\.([^,]+)/from: \1[\2(\1)], to: \3[\4(\3)]/' deps.csv > $@; \
	else \
		echo "electric-test: $(timeout)" >> running-times; \
	fi


# Tuscan Class-Only targets setup
%tuscan-class-only-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f tuscan-class-only-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode class-only testsuite > $@ 2> $*tuscan-class-only-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch tuscan-class-only-timed-out; \
		fi; \
		echo "tuscan-class-only: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "tuscan-class-only: $(timeout)" >> running-times; \
	fi


# Tuscan Intra-Class targets setup
%tuscan-intra-class-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f tuscan-intra-class-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode intra-class testsuite > $@ 2> $*tuscan-intra-class-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch tuscan-intra-class-timed-out; \
		fi; \
		echo "tuscan-intra-class: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "tuscan-intra-class: $(timeout)" >> running-times; \
	fi

# Tuscan Inter-Class targets setup
%tuscan-inter-class-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f tuscan-inter-class-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode inter-class testsuite > $@ 2> $*tuscan-inter-class-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch tuscan-inter-class-timed-out; \
		fi; \
		echo "tuscan-inter-class: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "tuscan-inter-class: $(timeout)" >> running-times; \
	fi

# Tuscan Packed targets setup
%tuscan-packed-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f tuscan-packed-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode packed testsuite > $@ 2> $*tuscan-packed-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch tuscan-packed-timed-out; \
		fi; \
		echo "tuscan-packed: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "tuscan-packed: $(timeout)" >> running-times; \
	fi

# Target Pairs targets setup
%target-pairs-conflicts.txt: %target-pairs-profiler-conflicts.txt
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f target-pairs-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode target-pairs $*target-pairs-profiler-conflicts.txt > $@ 2> $*target-pairs-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch target-pairs-timed-out; \
		fi; \
		echo "target-pairs: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "target-pairs: $(timeout)" >> running-times; \
	fi

%target-pairs-profiler-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@) ; \
	start_time="$$(date -u +%s)" ; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/moira/build/libs/moira.jar \
		-javaagent:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Xbootclasspath/a:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Dmoira.profiler.name=TargetPairsProfiler \
		-Dmoira.profiler.filename=$@ \
		-Dmoira.agent.filter=java/ \
		-Dmoira.agent.suspend='' \
		moira.Moira testsuite) && \
	echo "target-pairs-profiler: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times

.SECONDARY: $(foreach run,$(runs),run-$(run)/target-pairs-profiler-conflicts.txt)

# Moira targets setup
%moira-conflicts.txt: %online-profiler-conflicts.txt
	mkdir -p $(dir $@); touch $@; \
	if ! [ -f moira-timed-out ]; then \
		start_time="$$(date -u +%s)"; \
		$(call java_exec,-jar $(top_srcdir)/moira/util/build/libs/util.jar tuscan \
			-app-cp $$(cat classpath):target/classes/:target/test-classes/ \
			-mode pair-cover $*online-profiler-conflicts.txt > $@ 2> $*moira-progress.txt); \
		if [ $$? -eq 124 ]; then \
			touch moira-timed-out; \
		fi; \
		echo "moira: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times; \
	else \
		echo "moira: $(timeout)" >> running-times; \
	fi

%online-profiler-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@) ; \
	start_time="$$(date -u +%s)" ; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/moira/build/libs/moira.jar \
		-javaagent:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Xbootclasspath/a:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Dmoira.profiler.name=OnlineProfiler \
		-Dmoira.profiler.filename=$@ \
		moira.Moira testsuite) && \
	echo "online-profiler: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times

.SECONDARY: $(foreach run,$(runs),run-$(run)/online-profiler-conflicts.txt)

%-verified.txt: %-conflicts.txt
	touch $@; \
	already_done="$$(find . -name '*-verified.txt' -print0 | grep -vFz "$@" | xargs -0 sort | uniq)" ; \
	while read -r pair; do \
		if echo "$$already_done" | grep -cFq "$$pair"; then \
			echo "$$already_done" | grep -F "$$pair" >> $@; \
			continue; \
		fi ; \
		first="$$(printf "%s\n" "$$pair" | sed -e 's/from: \(.*\), to: .*$$/\1/')"; \
		second="$$(printf "%s\n" "$$pair" | sed -e 's/from: \(.*\), to: \(.*\)$$/\2/')"; \
		ordered="$$($(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/util/build/libs/util.jar moira.util.cli.MoiraUtil verify "$$first" "$$second") | grep OK)" ; \
		reversed="$$($(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/util/build/libs/util.jar moira.util.cli.MoiraUtil verify "$$second" "$$first") | grep OK)" ; \
		if test "$$ordered" = "$$reversed"; then \
			printf "%s, outcome: INVALID\n" "$$pair" >> $@; \
		else \
			printf "%s, outcome: VALID\n" "$$pair" >> $@; \
		fi; \
	done < $^



.PHONY: clean
clean:
	- rm -f running-times
	- rm -rf $(foreach run,$(runs),run-$(run))
	- rm -f $(foreach exp,electric-test tuscan-class-only tuscan-intra-class tuscan-inter-class tuscan-packed target-pairs moira,$(exp)-timed-out)
