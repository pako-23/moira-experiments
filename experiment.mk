runs := 1 2 3 4 5 6 7 8 9 10
experiments := online
experiment_files := $(foreach exp,$(experiments),$(exp)-conflicts.txt $(exp)-verified.txt) plain.txt

all: $(foreach run,$(runs),$(foreach file,$(experiment_files),run-$(run)/$(file))) access-logs

define mvn_exec
@if test -f mvnw; then \
	JAVA_HOME=$(JAVA_HOME) ./mvnw $(1); \
else \
	JAVA_HOME=$(JAVA_HOME) $(MVN_HOME)/bin/mvn $(1); \
fi
endef

define java_exec
if test $$($(JAVA_HOME)/bin/java -version 2>&1 | head -n 1 | awk -F '"' '{print $$2}' | cut -d. -f1) -ge 9; then \
	$(JAVA_HOME)/bin/java -Xss2m --add-opens java.base/java.util=ALL-UNNAMED --add-exports java.base/sun.security.jca=ALL-UNNAMED $(1); \
else \
	$(JAVA_HOME)/bin/java -Xss2m $(1); \
fi
endef

target:
	$(call mvn_exec,compile test-compile)

classpath: | target
	$(call mvn_exec,dependency:build-classpath -DincludeScope=test -Dmdep.outputFile=classpath)

testsuite: | target
	$(call mvn_exec,test) || true
	@find target/ -name 'TEST*.xml' -print0 | xargs -0 sed -n -e 's/^<testsuite .* name="\([^"]*\)".*$$/\1/p' | sort -u > testsuite

%plain.txt: testsuite classpath
	mkdir -p $(dir $@) ; \
	start_time="$$(date -u +%s)" ; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/ \
		org.junit.runner.JUnitCore $$(cat testsuite | tr '\n' ' ')) > $@ && \
	echo "time: $$(expr "$$(date -u +%s)" - "$$start_time")" >> $@

%online-conflicts.txt: testsuite classpath
	mkdir -p $(dir $@) ; \
	start_time="$$(date -u +%s)" ; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/moira/build/libs/moira.jar \
		-javaagent:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Xbootclasspath/a:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Dmoira.profiler.name=OnlineProfiler \
		-Dmoira.profiler.filename=$@ \
		moira.Moira $$(cat testsuite | tr '\n' ' ')) && \
	echo "online-profiler: $$(expr "$$(date -u +%s)" - "$$start_time")" >> running-times

access-logs:
	conflicts="$$(mktemp)" ; \
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/moira/build/libs/moira.jar \
		-javaagent:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Xbootclasspath/a:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Dmoira.profiler.name=OnlineProfiler \
		-Dmoira.profiler.filename=$$conflicts \
		moira.Moira $$(cat testsuite | tr '\n' ' ')  > $@)

%-verified.txt: %-conflicts.txt
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
	- rm -f $(experiment_files)
	- rm -rf $(foreach run,$(runs),run-$(run))
	- rm -f $(foreach exp,$(experiments),$(exp)-profile.svg $(exp)-traces.txt $(exp)-conflicts.txt)

.PHONY: profile
profile: $(foreach exp,$(experiments),$(exp)-profile.svg $(exp)-traces.txt $(exp)-conflicts.txt)

%-profile.svg: %-traces.txt
	@$(top_srcdir)/experiments/FlameGraph/stackcollapse-ljp.awk $^ | $(top_srcdir)/experiments/FlameGraph/flamegraph.pl > $@

online-conflicts.txt online-traces.txt &: testsuite classpath
	$(call java_exec,-cp $$(cat classpath):target/classes/:target/test-classes/:$(top_srcdir)/moira/moira/build/libs/moira.jar \
		-agentpath:$(top_srcdir)/experiments/lightweight-java-profiler/$(shell basename $(JAVA_HOME))/liblagent.so=file=online-traces.txt \
		-javaagent:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Xbootclasspath/a:$(top_srcdir)/moira/agent/build/libs/agent.jar \
		-Dmoira.profiler.name=OnlineProfiler \
		-Dmoira.profiler.filename=online-conflicts.txt \
		moira.Moira $$(cat testsuite | tr '\n' ' '))
