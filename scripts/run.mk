MOIRA_VERSION := 0.0.1

run-plain:
run-electric-test:
run-tuscan-class-only:
run-tuscan-intra-class:
run-tuscan-inter-class:
run-tuscan-packed:
run-target-pairs:
run-moira:


.PHONY: clean-experiments
clean-experiments:


define experiment_method =
.PHONY: run-$(1)-$(call experiment_id,$(2))
run-$(1)-$(call experiment_id,$(2)): \
	$(call experiment_repodir,$(2))/$(call experiment_subdir,$(2))Makefile \
	|  $(call experiment_java,$(2)) $(call experiment_mvn,$(2)) moira
	$(MAKE) -C $(call experiment_repodir,$(2))/$(call experiment_subdir,$(2)) $(1)

run-$(1): run-$(1)-$(call experiment_id,$(2))
run-$(call experiment_id,$(2)): run-$(1)-$(call experiment_id,$(2))
endef

define experiment =

# Repository setup section
ifndef $(subst /,-,$(call experiment_repodir,$(1)))_REPO
$(subst /,-,$(call experiment_repodir,$(1)))_REPO := 1

$(call experiment_repodir,$(1)): | $(call experiment_java,$(1)) $(call experiment_mvn,$(1))
	git clone --quiet https://github.com/$(word 2,$(subst $(comma), ,$(1))) $$@ && \
	cd $$@ && git -c advice.detachedHead=false checkout $(call experiment_commit,$(1)) && \
	if test -f $(call experiment_repodir,$(1))/mvnw; then \
		JAVA_HOME=$(PWD)/$(call experiment_java,$(1)) $(PWD)/$(call experiment_repodir,$(1))/mvnw install -Dmaven.javadoc.skip=true -DskipTests || true; \
	else \
		JAVA_HOME=$(PWD)/$(call experiment_java,$(1)) $(PWD)/$(call experiment_mvn,$(1))/bin/mvn install -Dmaven.javadoc.skip=true -DskipTests || true; \
	fi
endif

$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile: | $(call experiment_repodir,$(1))
	@printf "top_srcdir = $(PWD)\n" > $$@
	@printf "JAVA_HOME = $(PWD)/$(call experiment_java,$(1))\n" >> $$@
	@if test -f $(call experiment_repodir,$(1))/mvnw; then \
		printf "MVN_BIN = $(PWD)/$(call experiment_repodir,$(1))/mvnw\n" >> $$@; \
	else \
		printf "MVN_BIN = $(PWD)/$(call experiment_mvn,$(1))/bin/mvn\n" >> $$@; \
	fi
	@printf "MVN_HOME = $(PWD)/$(call experiment_mvn,$(1))\n" >> $$@
	@printf "TESTSUITE_FILTER = $(TESTSUITE_FILTER_$(call experiment_id,$(1)))\n" >> $$@
	@printf "include $(PWD)/scripts/experiment.mk\n" >> $$@

.PHONY: run-$(call experiment_id,$(1))
run-$(call experiment_id,$(1)):


# Plain execution section
.PHONY: run-plain-$(call experiment_id,$(1))
run-plain-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	| $(call experiment_java,$(1)) $(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) plain

run-plain: run-plain-$(call experiment_id,$(1))
run-$(call experiment_id,$(1)): run-plain-$(call experiment_id,$(1))

# ElectricTest execution section
.PHONY: run-electric-test-$(call experiment_id,$(1))
run-electric-test-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	$(EXPERIMENTS_DIR)/pradet-replication/datadep-detector/target/DependencyDetector-0.0.1-SNAPSHOT.jar \
	| $(call experiment_java,$(1)) $(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) electric-test

run-electric-test: run-electric-test-$(call experiment_id,$(1))
run-$(call experiment_id,$(1)): run-electric-test-$(call experiment_id,$(1))


$(eval $(call experiment_method,tuscan-class-only,$(1)))
$(eval $(call experiment_method,tuscan-intra-class,$(1)))
$(eval $(call experiment_method,tuscan-inter-class,$(1)))
$(eval $(call experiment_method,tuscan-packed,$(1)))
$(eval $(call experiment_method,target-pairs,$(1)))
$(eval $(call experiment_method,moira,$(1)))

# Cleanup targets section
.PHONY: clean-$(word 1,$(subst $(comma), ,$(1)))
clean-$(word 1,$(subst $(comma), ,$(1))):
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) clean

clean-experiments: clean-$(word 1,$(subst $(comma), ,$(1)))

endef

$(EXPERIMENTS_DIR)-joda-time_REPO := 1
$(EXPERIMENTS_DIR)/joda-time: | $(EXPERIMENTS_DIR)/apache-maven-3.6.1 $(EXPERIMENTS_DIR)/jdk8u462-b08
	git clone --quiet https://github.com/JodaOrg/joda-time $@ && \
	cd $@ && git -c advice.detachedHead=false checkout d1ea2a53929d7d56d4f4560852e5586517a0dd47 && \
	sed -i -e 's/3\.8\.2/4.13/' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 $(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn install -DskipTests || true

$(EXPERIMENTS_DIR)-riptide_REPO := 1
$(EXPERIMENTS_DIR)/riptide: | $(EXPERIMENTS_DIR)/apache-maven-3.6.1 $(EXPERIMENTS_DIR)/jdk8u462-b08
	git clone --quiet https://github.com/zalando/riptide $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 8277e11fc069d8e24df0d233ef2577cc75659b75 && \
	sed -i '/<plugin>/,/<\/plugin>/{H; /<plugin>/h; /<\/plugin>/!d; x;/dependency-check-maven/d;}' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 $(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn install -DskipTests || true

$(EXPERIMENTS_DIR)-dropwizard_REPO := 1
$(EXPERIMENTS_DIR)/dropwizard: | $(EXPERIMENTS_DIR)/apache-maven-3.6.1 $(EXPERIMENTS_DIR)/jdk8u462-b08
	git clone --quiet https://github.com/dropwizard/dropwizard $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 07dfaed697427e208d65049f80a5d1949833b7cd && \
	sed -i '/<plugin>/,/<\/plugin>/{H; /<plugin>/h; /<\/plugin>/!d; x;/dependency-check-maven/d;}' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 ./mvnw install -DskipTests || true


$(EXPERIMENTS_DIR):
	@mkdir $(EXPERIMENTS_DIR)

moira:
	rm -f moira-$(MOIRA_VERSION).tar && \
	wget https://github.com/pako-23/moira/releases/download/v$(MOIRA_VERSION)/moira-$(MOIRA_VERSION).tar && \
	tar xf moira-$(MOIRA_VERSION).tar && \
	rm moira-$(MOIRA_VERSION).tar && \
	mv moira-$(MOIRA_VERSION) moira

$(EXPERIMENTS_DIR)/pradet-replication:
	git clone https://github.com/gmu-swe/pradet-replication $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 2441dca323bf828cb0e506c63381eff23d3d7af0

$(EXPERIMENTS_DIR)/pradet-replication/datadep-detector: | $(EXPERIMENTS_DIR)/pradet-replication
	git clone https://github.com/skappler/datadep-detector $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 0a07be1614a54017c14fdb6472059e04abf1a933

$(EXPERIMENTS_DIR)/pradet-replication/datadep-detector/target/DependencyDetector-0.0.1-SNAPSHOT.jar: \
	| $(EXPERIMENTS_DIR)/pradet-replication/datadep-detector \
	$(EXPERIMENTS_DIR)/jdk8u462-b08 \
	$(EXPERIMENTS_DIR)/apache-maven-3.6.1
	cd $(EXPERIMENTS_DIR)/pradet-replication/datadep-detector && \
	JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 \
	$(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn clean install -DskipTests

$(EXPERIMENTS_DIR)/jdk8u462-b08: | $(EXPERIMENTS_DIR)
	@cd $(EXPERIMENTS_DIR) && rm -f OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz && \
	wget -q https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u462-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz && \
	tar xf OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz && \
	rm -f OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz

$(EXPERIMENTS_DIR)/jdk-24.0.2+12: | $(EXPERIMENTS_DIR)
	@cd $(EXPERIMENTS_DIR) && rm -f OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz && \
	wget -q https://github.com/adoptium/temurin24-binaries/releases/download/jdk-24.0.2%2B12/OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz && \
	tar xf OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz && \
	rm -f OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz

.PHONY: java-versions
java-versions: $(EXPERIMENTS_DIR)/jdk8u462-b08 $(EXPERIMENTS_DIR)/jdk-24.0.2+12

define mvn_version =
$(EXPERIMENTS_DIR)/apache-maven-$(1): | $(EXPERIMENTS_DIR)
	@wget -q https://archive.apache.org/dist/maven/maven-$(word 1,$(subst ., ,$(1)))/$(1)/binaries/apache-maven-$(1)-bin.tar.gz -P /tmp && \
	tar xf /tmp/apache-maven-$(1)-bin.tar.gz -C $(EXPERIMENTS_DIR)

.PHONY: mvn-versions
mvn-versions: $(EXPERIMENTS_DIR)/apache-maven-$(1)
endef

.PHONY: mvn-versions
mvn-versions:

$(eval $(call mvn_version,3.6.1))
$(eval $(call mvn_version,3.9.9))


.PHONY: clean
clean:
	- rm -rf $(EXPERIMENTS_DIR)
	- rm -rf moira
