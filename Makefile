EXPERIMENTS_DIR := experiments

.PHONY: all run-plain run-electric-test run-tuscan-class-only \
	run-tuscan-intra-class run-tuscan-inter-class \
	run-tuscan-packed
all: run-plain run-electric-test run-tuscan-class-only \
	run-tuscan-intra-class run-tuscan-inter-class \
	run-tuscan-packed

run-plain:
run-electric-test:
run-tuscan-class-only:
run-tuscan-intra-class:
run-tuscan-inter-class:
run-tuscan-packed:

.PHONY: plain-stats electric-test-stats tuscan-class-only-stats tuscan-intra-class-stats
plain-stats:
electric-test-stats:
tuscan-class-only-stats:
tuscan-intra-class-stats:

.PHONY: clean-experiments
clean-experiments:

SUBJECTS := \
	aismessages,tbsalling/aismessages,7b0c4c708b6bb9a6da3d5737bcad1857ade8a931,.,jdk8u462-b08,apache-maven-3.6.1 \
	c2mon-server-elasticsearch,c2mon/c2mon,d80687b119c713dd177a58cf53a997d8cc5ca264,c2mon-server/c2mon-server-elasticsearch,jdk8u462-b08,apache-maven-3.6.1 \
	cukes-http,ctco/cukes,b483e1a8f261b80a66291a42fc455256b0b5059c,cukes-http,jdk8u462-b08,apache-maven-3.6.1 \
	dropwizard-logging,dropwizard/dropwizard,07dfaed697427e208d65049f80a5d1949833b7cd,dropwizard-logging,jdk8u462-b08,apache-maven-3.6.1 \
	elastic-job-lite-core,elasticjob/elastic-job-lite,b022898ef1b8c984e17efb2a422ee45f6b13e46e,elastic-job-lite-core,jdk8u462-b08,apache-maven-3.6.1 \
	fastjson,alibaba/fastjson,5c6d6fd471ea1fab59f0df2dd31e0b936806780d,.,jdk8u462-b08,apache-maven-3.6.1 \
	guava,google/guava,8868c096cfdabbe38170b6e395369c315cfb72a1,guava-tests,jdk-24.0.2+12,apache-maven-3.9.9 \
	http-request,kevinsawicki/http-request,2d62a3e9da726942a93cf16b6e91c0187e6c0136,lib,jdk8u462-b08,apache-maven-3.6.1 \
	jhipster-registry,jhipster/jhipster-registry,00db36611da5fc7aaf9d5372aa90f2465d80c0c4,.,jdk8u462-b08,apache-maven-3.6.1 \
	joda-time,JodaOrg/joda-time,d1ea2a53929d7d56d4f4560852e5586517a0dd47,.,jdk8u462-b08,apache-maven-3.6.1 \
	marine-api,ktuukkan/marine-api,af0003847db9ba822f67d4f1dceb8de3fe63250a,.,jdk8u462-b08,apache-maven-3.6.1 \
	naming,wildfly/wildfly,b19048b72669fc0e96665b1b125dc1fda21f5993,naming,jdk8u462-b08,apache-maven-3.6.1 \
	openpojo,openpojo/openpojo,3b8f736754bbd356e3278e19273cd7aa2dd77f30,.,jdk8u462-b08,apache-maven-3.6.1 \
	portlet,apache/struts,13d9053050c9e4fb2ef049db6a37d3f6eebf48fa,plugins/portlet,jdk8u462-b08,apache-maven-3.6.1 \
	request,vmware/admiral,e4b02936cc7d4ff2714e7231db0c4373ba5d48a2,request,jdk8u462-b08,apache-maven-3.6.1 \
	riptide,zalando/riptide,8277e11fc069d8e24df0d233ef2577cc75659b75,riptide-spring-boot-starter,jdk8u462-b08,apache-maven-3.6.1 \
	spring-boot,spring-projects/spring-boot,daa3d457b71896a758995c264977bdd1414ee4d4,spring-boot-project/spring-boot,jdk8u462-b08,apache-maven-3.6.1 \
	spring-boot-actuator-autoconfigure,spring-projects/spring-boot,daa3d457b71896a758995c264977bdd1414ee4d4,spring-boot-project/spring-boot-actuator-autoconfigure,jdk8u462-b08,apache-maven-3.6.1 \
	spring-boot-test,spring-projects/spring-boot,daa3d457b71896a758995c264977bdd1414ee4d4,spring-boot-project/spring-boot-test,jdk8u462-b08,apache-maven-3.6.1 \
	spring-boot-test-autoconfigure,spring-projects/spring-boot,daa3d457b71896a758995c264977bdd1414ee4d4,spring-boot-project/spring-boot-test-autoconfigure,jdk8u462-b08,apache-maven-3.6.1 \
	spring-data-ebean,hexagonframework/spring-data-ebean,dd11b97654982403b50dd1d5369cadad71fce410,.,jdk8u462-b08,apache-maven-3.6.1 \
	spring-data-envers,spring-projects/spring-data-envers,aab9302d0223f86316b5b0fcf8de336cea2f74f1,.,jdk8u462-b08,apache-maven-3.6.1 \
	spring-ws-core,spring-projects/spring-ws,e8d89c9eb0929dda304174729c9c69fb29f448eb,spring-ws-core,jdk8u462-b08,apache-maven-3.6.1 \
	spring-ws-security,spring-projects/spring-ws,e8d89c9eb0929dda304174729c9c69fb29f448eb,spring-ws-security,jdk8u462-b08,apache-maven-3.6.1 \
	subsystem,wildfly/wildfly,b19048b72669fc0e96665b1b125dc1fda21f5993,security/subsystem,jdk8u462-b08,apache-maven-3.6.1 \
	unix4j-command,tools4j/unix4j,367da7d262e682a08577cdf19ebbbdd8a46870fe,unix4j-core/unix4j-command,jdk8u462-b08,apache-maven-3.6.1 \
	wdtk-dumpfiles,wikidata/wikidata-toolkit,20de6f7f12319f54eb962ff6e8357b3f5695d54d,wdtk-dumpfiles,jdk8u462-b08,apache-maven-3.6.1 \
	wdtk-util,wikidata/wikidata-toolkit,20de6f7f12319f54eb962ff6e8357b3f5695d54d,wdtk-util,jdk8u462-b08,apache-maven-3.6.1 \
	wro4j-core,wro4j/wro4j,185ab607f1d649ca38b4a772831ee754cd4649fb,wro4j-core,jdk8u462-b08,apache-maven-3.6.1


comma := ,
experiment_id = $(word 1,$(subst $(comma), ,$(1)))
experiment_repo = $(word 2,$(subst $(comma), ,$(1)))
experiment_repodir = $(EXPERIMENTS_DIR)/$(word 2,$(subst /, ,$(call experiment_repo,$(1))))
experiment_commit = $(word 3,$(subst $(comma), ,$(1)))
experiment_subdir = $(if $(filter .,$(word 4,$(subst $(comma), ,$(1)))),,$(word 4,$(subst $(comma), ,$(1)))/)
experiment_java = $(EXPERIMENTS_DIR)/$(word 5,$(subst $(comma), ,$(1)))
experiment_mvn = $(EXPERIMENTS_DIR)/$(word 6,$(subst $(comma), ,$(1)))

execution_time = echo "Execution Time: $$$$(./scripts/running-times.pl $(1) $(2) | ./scripts/avgse.pl | ./scripts/display.pl)"
pairs_found = if test -d $(1); then echo "Pairs Found: $$$$(find $(1) -name $(2)-conflicts.txt -exec wc -l {} \; | awk '{print $$$$1}' | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "Pairs Found: N/A"; fi
flaky_tests = if test -d $(1); then echo "Flaky Tests: $$$$(find $(1) -name $(2)-conflicts.txt -exec ./scripts/flaky-tests.pl {} \; | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "Flaky Tests: N/A"; fi

define experiment =

# Repository setup section
ifndef $(subst /,-,$(call experiment_repodir,$(1)))_REPO
$(subst /,-,$(call experiment_repodir,$(1)))_REPO := 1

$(call experiment_repodir,$(1)): | $(call experiment_java,$(1)) $(call experiment_mvn,$(1))
	git clone --quiet https://github.com/$(word 2,$(subst $(comma), ,$(1))) $$@ && \
	cd $$@ && git -c advice.detachedHead=false checkout $(call experiment_commit,$(1)) && \
	if test -f $(call experiment_repodir,$(1))/mvnw; then \
		JAVA_HOME=$(PWD)/$(call experiment_java,$(1)) $(PWD)/$(call experiment_repodir,$(1))/mvnw install -DskipTests || true; \
	else \
		JAVA_HOME=$(PWD)/$(call experiment_java,$(1)) $(PWD)/$(call experiment_mvn,$(1))/bin/mvn install -DskipTests || true; \
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
	@printf "include $(PWD)/experiment.mk\n" >> $$@


# Plain execution section
.PHONY: run-plain-$(call experiment_id,$(1))
run-plain-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) plain


# ElectricTest execution section
.PHONY: run-electric-test-$(call experiment_id,$(1))
run-electric-test-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	$(EXPERIMENTS_DIR)/pradet-replication/datadep-detector/target/DependencyDetector-0.0.1-SNAPSHOT.jar \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) electric-test


# Tuscan Class-Only execution section
.PHONY: run-tuscan-class-only-$(call experiment_id,$(1))
run-tuscan-class-only-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/util/build/libs/util.jar \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) tuscan-class-only


# Tuscan Intra-Class execution section
.PHONY: run-tuscan-intra-class-$(call experiment_id,$(1))
run-tuscan-intra-class-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/util/build/libs/util.jar \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) tuscan-intra-class

# Tuscan Inter-Class execution section
.PHONY: run-tuscan-inter-class-$(call experiment_id,$(1))
run-tuscan-inter-class-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/util/build/libs/util.jar \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) tuscan-inter-class

# Tuscan Packed execution section
.PHONY: run-tuscan-packed-$(call experiment_id,$(1))
run-tuscan-packed-$(call experiment_id,$(1)): \
	$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/util/build/libs/util.jar \
	| $(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1))
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) tuscan-packed

# All targets section
.PHONY: run-$(call experiment_id,$(1))
run-$(call experiment_id,$(1)): \
	run-plain-$(call experiment_id,$(1)) \
	run-electric-test-$(call experiment_id,$(1))
	run-tuscan-class-only-$(call experiment_id,$(1))
	run-tuscan-intra-class-$(call experiment_id,$(1))

run-plain: run-plain-$(call experiment_id,$(1))
run-electric-test: run-electric-test-$(call experiment_id,$(1))
run-tuscan-class-only: run-tuscan-class-only-$(call experiment_id,$(1))
run-tuscan-intra-class: run-tuscan-intra-class-$(call experiment_id,$(1))
run-tuscan-inter-class: run-tuscan-inter-class-$(call experiment_id,$(1))
run-tuscan-packed: run-tuscan-packed-$(call experiment_id,$(1))


# Statistics targets
.PHONY: plain-stats-$(call experiment_id,$(1))
plain-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),plain)
	@echo ""

plain-stats: plain-stats-$(call experiment_id,$(1))


.PHONY: electric-test-stats-$(call experiment_id,$(1))
electric-test-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),electric-test)
	@echo "Setup Execution Time: $$$$(./scripts/running-times.pl $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) electric-test-setup  | ./scripts/display.pl)"
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),electric-test)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),electric-test)
	@echo ""

electric-test-stats: electric-test-stats-$(call experiment_id,$(1))


.PHONY: tuscan-class-only-stats-$(call experiment_id,$(1))
tuscan-class-only-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-class-only)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-class-only)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-class-only)
	@echo ""

tuscan-class-only-stats: tuscan-class-only-stats-$(call experiment_id,$(1))


.PHONY: tuscan-intra-class-stats-$(call experiment_id,$(1))
tuscan-intra-class-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@echo ""

tuscan-intra-class-stats: tuscan-intra-class-stats-$(call experiment_id,$(1))


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


$(foreach s,$(SUBJECTS),$(eval $(call experiment,$(s))))


$(EXPERIMENTS_DIR):
	@mkdir $(EXPERIMENTS_DIR)

moira:
	git clone --quiet https://github.com/pako-23/moira.git

moira/agent/build/libs/agent.jar: | moira
	cd moira && ./gradlew agent:build

moira/moira/build/libs/moira.jar: | moira
	cd moira && ./gradlew moira:build

moira/util/build/libs/util.jar: | moira
	cd moira && ./gradlew util:build

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
	@wget -q https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u462-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz -P /tmp && \
	tar xf /tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz -C $(EXPERIMENTS_DIR)

$(EXPERIMENTS_DIR)/jdk-24.0.2+12: | $(EXPERIMENTS_DIR)
	@wget -q https://github.com/adoptium/temurin24-binaries/releases/download/jdk-24.0.2%2B12/OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz -P /tmp && \
	tar xf /tmp/OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz -C $(EXPERIMENTS_DIR)

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
	rm -rf $(EXPERIMENTS_DIR)
