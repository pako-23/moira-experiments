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


EXPERIMENTS_DIR := experiments
comma := ,
experiment_id = $(word 1,$(subst $(comma), ,$(1)))
experiment_repo = $(word 2,$(subst $(comma), ,$(1)))
experiment_repodir = $(EXPERIMENTS_DIR)/$(word 2,$(subst /, ,$(call experiment_repo,$(1))))
experiment_commit = $(word 3,$(subst $(comma), ,$(1)))
experiment_subdir = $(if $(filter .,$(word 4,$(subst $(comma), ,$(1)))),,$(word 4,$(subst $(comma), ,$(1)))/)
experiment_java = $(EXPERIMENTS_DIR)/$(word 5,$(subst $(comma), ,$(1)))
experiment_mvn = $(EXPERIMENTS_DIR)/$(word 6,$(subst $(comma), ,$(1)))
