.PHONY: all run-plain run-electric-test run-tuscan-class-only \
	run-tuscan-intra-class run-tuscan-inter-class \
	run-tuscan-packed run-target-pairs run-moira
all: run-plain run-electric-test run-tuscan-class-only \
	run-tuscan-intra-class run-tuscan-inter-class \
	run-tuscan-packed run-target-pairs run-moira

include scripts/subjects.mk
include scripts/run.mk

$(foreach s,$(SUBJECTS),$(eval $(call experiment,$(s))))

include scripts/stats.mk

$(foreach s,$(SUBJECTS),$(eval $(call stats,$(s))))

.PHONY: dist
dist: results.tar.gz

results.tar.gz:
	@tar -cf results.tar -T /dev/null
	@for run in $$(find experiments/ -regex '.*/run-[0-9]+.*' -type d); do \
		tar -rf results.tar  $$run; \
	done
	@for file in $$(find experiments/ -name running-times -type f); do \
		tar -rf results.tar  $$file; \
	done
	@for script in scripts/stats.mk scripts/subjects.mk scripts/*.pl; do \
		tar -rf results.tar  $$script; \
	done
	@echo 'include scripts/subjects.mk' > Makefile.dist
	@echo 'include scripts/stats.mk' >> Makefile.dist
	@echo '$$(foreach s,$$(SUBJECTS),$$(eval $$(call stats,$$(s))))' >> Makefile.dist
	@tar -rf results.tar --transform='s/Makefile.dist/Makefile/' Makefile.dist
	@rm Makefile.dist
	@gzip results.tar
