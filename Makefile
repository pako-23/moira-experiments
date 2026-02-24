EXPERIMENTS_DIR := experiments

.PHONY: all
all: | java-versions mvn-versions

.PHONY: profile
profile:

.PHONY: clean-experiments
clean-experiments:

SUBJECTS := aismessages,tbsalling/aismessages,7b0c4c708b6bb9a6da3d5737bcad1857ade8a931,.,jdk8u462-b08,apache-maven-3.6.1 \
	c2mon-server-elasticsearch,c2mon/c2mon,d80687b119c713dd177a58cf53a997d8cc5ca264,c2mon-server/c2mon-server-elasticsearch,jdk8u462-b08,apache-maven-3.6.1 \
	compute,vmware/admiral,e4b02936cc7d4ff2714e7231db0c4373ba5d48a2,compute,jdk8u462-b08,apache-maven-3.6.1 \
	cukes-http,ctco/cukes,b483e1a8f261b80a66291a42fc455256b0b5059c,cukes-http,jdk8u462-b08,apache-maven-3.6.1 \
	dropwizard-logging,dropwizard/dropwizard,07dfaed697427e208d65049f80a5d1949833b7cd,dropwizard-logging,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-cluster,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-cluster,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-common,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-common,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-config-api,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-config/dubbo-config-api,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-filter-cache,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-filter/dubbo-filter-cache,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-rpc-api,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-rpc/dubbo-rpc-api,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-rpc-dubbo,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-rpc/dubbo-rpc-dubbo,jdk8u462-b08,apache-maven-3.6.1 \
	dubbo-serialization-fst,apache/dubbo,737f7a7ea67832d7f17517326fb2491d0a086dd7,dubbo-serialization/dubbo-serialization-fst,jdk8u462-b08,apache-maven-3.6.1 \
	elastic-job-lite-core,elasticjob/elastic-job-lite,b022898ef1b8c984e17efb2a422ee45f6b13e46e,elastic-job-lite-core,jdk8u462-b08,apache-maven-3.6.1 \
	fastjson,alibaba/fastjson,5c6d6fd471ea1fab59f0df2dd31e0b936806780d,.,jdk8u462-b08,apache-maven-3.6.1 \
	guava,google/guava,8868c096cfdabbe38170b6e395369c315cfb72a1,guava-tests,jdk-24.0.2+12,apache-maven-3.9.9 \
	hadoop-auth,apache/hadoop,aa96f1871bfd858f9bac59cf2a81ec470da649af,hadoop-common-project/hadoop-auth,jdk8u462-b08,apache-maven-3.6.1 \
	hadoop-hdfs-nfs,apache/hadoop,aa96f1871bfd858f9bac59cf2a81ec470da649af,hadoop-hdfs-project/hadoop-hdfs-nfs,jdk8u462-b08,apache-maven-3.6.1 \
	hadoop-mapreduce-client-app,apache/hadoop,aa96f1871bfd858f9bac59cf2a81ec470da649af,hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-app,jdk8u462-b08,apache-maven-3.6.1 \
	hadoop-mapreduce-client-core,apache/hadoop,aa96f1871bfd858f9bac59cf2a81ec470da649af,hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-core,jdk8u462-b08,apache-maven-3.6.1 \
	hadoop-mapreduce-client-hs,apache/hadoop,aa96f1871bfd858f9bac59cf2a81ec470da649af,hadoop-mapreduce-project/hadoop-mapreduce-client/hadoop-mapreduce-client-hs,jdk8u462-b08,apache-maven-3.6.1 \
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
	spring-boot-actuator-autoconfigure,spring-projects/spring-boot daa3d457b71896a758995c264977bdd1414ee4d4,spring-boot-project/spring-boot-actuator-autoconfigure,jdk8u462-b08,apache-maven-3.6.1 \
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

define experiment =

ifndef $(subst /,-,$(call experiment_repodir,$(1)))_REPO
$(subst /,-,$(call experiment_repodir,$(1)))_REPO := 1

$(call experiment_repodir,$(1)):
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

.PHONY: run-$(call experiment_id,$(1))
run-$(call experiment_id,$(1)): $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/moira/build/libs/moira.jar \
	moira/agent/build/libs/agent.jar \
	moira/util/build/libs/util.jar \
	$(call experiment_repodir,$(1)) \
	$(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1)) | $(EXPERIMENTS_DIR)/pradet-replication
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) all

all: run-$(word 1,$(subst $(comma), ,$(1)))

.PHONY: clean-$(word 1,$(subst $(comma), ,$(1)))
clean-$(word 1,$(subst $(comma), ,$(1))):
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) clean

clean-experiments: clean-$(word 1,$(subst $(comma), ,$(1)))

.PHONY: profile-$(call experiment_id,$(1))
profile-$(call experiment_id,$(1)): $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1))Makefile \
	moira/moira/build/libs/moira.jar \
	moira/agent/build/libs/agent.jar \
	$(EXPERIMENTS_DIR)/lightweight-java-profiler/$(word 5,$(subst $(comma), ,$(1)))/liblagent.so | \
	$(call experiment_repodir,$(1)) \
	$(call experiment_java,$(1)) \
	$(call experiment_mvn,$(1)) \
	$(EXPERIMENTS_DIR)/FlameGraph
	$(MAKE) -C $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) profile

profile: profile-$(word 1,$(subst $(comma), ,$(1)))

endef

$(EXPERIMENTS_DIR)-joda-time_REPO := 1
$(EXPERIMENTS_DIR)/joda-time: | $(EXPERIMENTS_DIR)
	git clone --quiet https://github.com/JodaOrg/joda-time $@ && \
	cd $@ && git -c advice.detachedHead=false checkout d1ea2a53929d7d56d4f4560852e5586517a0dd47 && \
	sed -i -e 's/3\.8\.2/4.13/' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 $(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn install -DskipTests || true

$(EXPERIMENTS_DIR)-riptide_REPO := 1
$(EXPERIMENTS_DIR)/riptide: | $(EXPERIMENTS_DIR)
	git clone --quiet https://github.com/zalando/riptide $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 8277e11fc069d8e24df0d233ef2577cc75659b75 && \
	sed -i '/<plugin>/,/<\/plugin>/{H; /<plugin>/h; /<\/plugin>/!d; x;/dependency-check-maven/d;}' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 $(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn install -DskipTests || true

$(EXPERIMENTS_DIR)-dropwizard_REPO := 1
$(EXPERIMENTS_DIR)/dropwizard: | $(EXPERIMENTS_DIR)
	git clone --quiet https://github.com/dropwizard/dropwizard $@ && \
	cd $@ && git -c advice.detachedHead=false checkout 07dfaed697427e208d65049f80a5d1949833b7cd && \
	sed -i '/<plugin>/,/<\/plugin>/{H; /<plugin>/h; /<\/plugin>/!d; x;/dependency-check-maven/d;}' pom.xml
	cd $@ && JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 ./mvnw install -DskipTests || true


$(foreach s,$(SUBJECTS),$(eval $(call experiment,$(s))))


$(EXPERIMENTS_DIR):
	@mkdir $(EXPERIMENTS_DIR)

moira:
	git clone --quiet -b v0.0.1 https://github.com/pako-23/moira.git

moira/agent/build/libs/agent.jar: | moira
	cd moira && ./gradlew agent:build

moira/moira/build/libs/moira.jar: | moira
	cd moira && ./gradlew moira:build

moira/util/build/libs/util.jar: | moira
	cd moira && ./gradlew util:build

$(EXPERIMENTS_DIR)/pradet-replication: | $(EXPERIMENTS_DIR)/jdk8u462-b08 $(EXPERIMENTS_DIR)/apache-maven-3.6.1
	git clone --quiet https://github.com/gmu-swe/pradet-replication $@ && \
	cd $@ && git clone https://github.com/skappler/datadep-detector && cd datadep-detector && \
	JAVA_HOME=$(PWD)/$(EXPERIMENTS_DIR)/jdk8u462-b08 $(PWD)/$(EXPERIMENTS_DIR)/apache-maven-3.6.1/bin/mvn clean install -DskipTests

$(EXPERIMENTS_DIR)/jdk8u462-b08: | $(EXPERIMENTS_DIR)
	@wget -q https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u462-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz -P /tmp && \
	tar xf /tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u462b08.tar.gz -C $(EXPERIMENTS_DIR)

$(EXPERIMENTS_DIR)/jdk-24.0.2+12: | $(EXPERIMENTS_DIR)
	@wget -q https://github.com/adoptium/temurin24-binaries/releases/download/jdk-24.0.2%2B12/OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz -P /tmp && \
	tar xf /tmp/OpenJDK24U-jdk_x64_linux_hotspot_24.0.2_12.tar.gz -C $(EXPERIMENTS_DIR)

.PHONY: java-versions
java-versions: | $(EXPERIMENTS_DIR)/jdk8u462-b08

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

$(EXPERIMENTS_DIR)/lightweight-java-profiler: | $(EXPERIMENTS_DIR)
	@git clone --quiet https://github.com/yinheli/lightweight-java-profiler.git $@

define profiler_version
$(EXPERIMENTS_DIR)/lightweight-java-profiler/$(1)/liblagent.so: | $(EXPERIMENTS_DIR)/lightweight-java-profiler $(EXPERIMENTS_DIR)/$(1)
	cd $(EXPERIMENTS_DIR)/lightweight-java-profiler && \
	mkdir $(1) && \
	$(MAKE) BITS=64 BUILD_DIR=$(1) INCLUDES='-I$(PWD)/$(EXPERIMENTS_DIR)/$(1)/include -I$(PWD)/$(EXPERIMENTS_DIR)/$(1)/include/linux' all
endef

$(eval $(call profiler_version,jdk8u462-b08))
$(eval $(call profiler_version,jdk-24.0.2+12))

$(EXPERIMENTS_DIR)/FlameGraph: | $(EXPERIMENTS_DIR)
	@git clone --quiet https://github.com/brendangregg/FlameGraph.git $@
