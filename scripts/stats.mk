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

execution_time = echo "Execution Time: $$$$(./scripts/running-times.pl $(1) $(2) | ./scripts/avgse.pl | ./scripts/display.pl)"
pairs_found = if test -d $(1); then echo "Pairs Found: $$$$(find $(1) -name $(2)-conflicts.txt -exec wc -l {} \; | awk '{print $$$$1}' | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "Pairs Found: N/A"; fi
flaky_tests = if test -d $(1); then echo "Flaky Tests: $$$$(find $(1) -name $(2)-conflicts.txt -exec ./scripts/flaky-tests.pl {} \; | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "Flaky Tests: N/A"; fi
progress = if test -d $(1); then echo "Progress: $$$$(find $(1) -name $(2)-progress.txt -exec ./scripts/progress.pl {} \; | ./scripts/avgse.pl | ./scripts/display.pl)"; else echo "Progress: N/A"; fi

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
	@echo -n 'Profiler ' && $(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@echo -n 'Profiler ' && $(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@echo -n 'Profiler ' && $(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs-profiler)
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),target-pairs)
	@echo ""

target-pairs-stats: target-pairs-stats-$(call experiment_id,$(1))


.PHONY: moira-stats-$(call experiment_id,$(1))
moira-stats-$(call experiment_id,$(1)):
	@echo "=== $(call experiment_id,$(1)) ==="
	@echo -n 'Profiler ' && $(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@echo -n 'Profiler ' && $(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@echo -n 'Profiler ' && $(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),online-profiler)
	@$(call execution_time,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call pairs_found,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call flaky_tests,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@$(call progress,$(call experiment_repodir,$(1))/$(call experiment_subdir,$(1)),moira)
	@echo ""

moira-stats: moira-stats-$(call experiment_id,$(1))

endef
