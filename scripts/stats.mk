.PHONY: plain-stats electric-test-stats tuscan-class-only-stats \
	tuscan-intra-class-stats tuscan-inter-class-stats tuscan-packed-stats \
	target-pairs-stats moira-stats

plain-stats:
electric-test-stats:
tuscan-class-only-stats:
tuscan-intra-class-stats:
tuscan-inter-class-stats:
tuscan-packed-stats:
target-pairs-stats:
moira-stats:

execution_time = echo "execution time: $$$$(./scripts/running-times.pl $(1) $(2) | ./scripts/avgse.pl | ./scripts/display.pl)"
pairs_found = if test -d $(1); then echo "pairs found: $$$$(find $(1) -name $(2)-conflicts.txt -exec wc -l {} \; | awk '{print $$$$1}' | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "pairs found: N/A"; fi
flaky_tests = if test -d $(1); then echo "flaky tests: $$$$(find $(1) -name $(2)-conflicts.txt -exec ./scripts/flaky-tests.pl {} \; | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "flaky tests: N/A"; fi
progress = if test -d $(1); then echo "progress: $$$$(find $(1) -name $(2)-progress.txt -exec ./scripts/progress.pl {} \; | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "progress: N/A"; fi

diff = echo -n "$(1) join: "; \
if test -d $(2); then \
	for i in 1 2 3 4 5 6 7 8 9 10; do \
		if test -f $(2)run-$$$$i/$(3)-conflicts.txt && test -f $(2)run-$$$$i/$(4)-conflicts.txt; then \
			./scripts/join.pl --type $(1) $(2)run-$$$$i/$(3)-conflicts.txt $(2)run-$$$$i/$(4)-conflicts.txt | wc -l; \
		fi; \
	done | ./scripts/avgse.pl | ./scripts/display.pl; \
else \
	echo "N/A"; \
fi

baseline_diff = echo -n "baseline $(1) join: "; \
if test -d $(2); then \
	for i in 1 2 3 4 5 6 7 8 9 10; do \
		if test -f $(2)run-$$$$i/$(3)-conflicts.txt; then \
			./scripts/join.pl --type $(1) $(2)run-$$$$i/$(3)-conflicts.txt ./baseline/$(4) | wc -l; \
		fi; \
	done | ./scripts/avgse.pl | ./scripts/display.pl; \
else \
	echo "N/A"; \
fi

define stats =
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
	@echo "setup execution Time: $$$$(./scripts/running-times.pl $(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)) electric-test-setup  | ./scripts/display.pl)"
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
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-class-only)
	@echo ""

tuscan-class-only-stats: tuscan-class-only-stats-$(call experiment_id,$(1))


.PHONY: tuscan-intra-class-stats-$(call experiment_id,$(1))
tuscan-intra-class-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-intra-class)
	@echo ""

tuscan-intra-class-stats: tuscan-intra-class-stats-$(call experiment_id,$(1))


.PHONY: tuscan-inter-class-stats-$(call experiment_id,$(1))
tuscan-inter-class-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-inter-class)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-inter-class)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-inter-class)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-inter-class)
	@echo ""

tuscan-inter-class-stats: tuscan-inter-class-stats-$(call experiment_id,$(1))


.PHONY: tuscan-packed-stats-$(call experiment_id,$(1))
tuscan-packed-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-packed)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-packed)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-packed)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),tuscan-packed)
	@echo ""

tuscan-packed-stats: tuscan-packed-stats-$(call experiment_id,$(1))


.PHONY: target-pairs-stats-$(call experiment_id,$(1))
target-pairs-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@echo -n 'profiler ' && $(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@echo -n 'profiler ' && $(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@echo -n 'profiler ' && $(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@echo ""

target-pairs-stats: target-pairs-stats-$(call experiment_id,$(1))


.PHONY: moira-stats-$(call experiment_id,$(1))
moira-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@echo -n 'profiler ' && $(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@echo -n 'profiler ' && $(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@echo -n 'profiler ' && $(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@echo -n 'electric-test ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,electric-test)
	@echo -n 'electric-test ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,electric-test)
	@echo -n 'electric-test ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,electric-test)
	@echo -n 'tuscan-class-only ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-class-only)
	@echo -n 'tuscan-class-only ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-class-only)
	@echo -n 'tuscan-class-only ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-class-only)
	@echo -n 'tuscan-intra-class ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-intra-class)
	@echo -n 'tuscan-intra-class ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-intra-class)
	@echo -n 'tuscan-intra-class ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-intra-class)
	@echo -n 'tuscan-inter-class ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-inter-class)
	@echo -n 'tuscan-inter-class ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-inter-class)
	@echo -n 'tuscan-inter-class ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-inter-class)
	@echo -n 'tuscan-packed ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-packed)
	@echo -n 'tuscan-packed ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-packed)
	@echo -n 'tuscan-packed ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,tuscan-packed)
	@echo -n 'target-pairs ' && $(call diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,target-pairs)
	@echo -n 'target-pairs ' && $(call diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,target-pairs)
	@echo -n 'target-pairs ' && $(call diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,target-pairs)
	@$(call baseline_diff,inner,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,$(call experiment_id,$(1)))
	@$(call baseline_diff,left,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,$(call experiment_id,$(1)))
	@$(call baseline_diff,right,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira,$(call experiment_id,$(1)))
	@echo ""

moira-stats: moira-stats-$(call experiment_id,$(1))

endef
