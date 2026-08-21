GP ?= gp
GAP ?= gap
MAGMA ?= magma
PYTHON ?= python3

HJLPPZ := $(CURDIR)/families/hjlppz-2026/polynomial_F.gp
ELKIES := $(CURDIR)/families/elkies-2013/elkies_cover.gp

.PHONY: verify verify-all vertical-different tame-resolvents semilinear-covariance stable-group verify-magma verify-magma-generated magma-vertical-different magma-tame-resolvents magma-semilinear-covariance magma-stable-group

verify: vertical-different tame-resolvents semilinear-covariance stable-group

verify-all: verify verify-magma

vertical-different:
	@M23_ZETA_HJLPPZ_POLY="$(HJLPPZ)" \
	 M23_ZETA_ELKIES_COVER="$(ELKIES)" \
	 $(GP) -q -f -s 512M scripts/certify_p23_vertical_different.gp

tame-resolvents:
	@M23_ZETA_HJLPPZ_POLY="$(HJLPPZ)" \
	 M23_ZETA_ELKIES_COVER="$(ELKIES)" \
	 $(GP) -q -f -s 512M scripts/certify_p23_tame_resolvents.gp

semilinear-covariance:
	@$(GP) -q -f scripts/certify_p23_semilinear_covariance.gp

stable-group:
	@$(GAP) -A -q scripts/certify_p23_stable_group.g

verify-magma: verify-magma-generated magma-vertical-different magma-tame-resolvents magma-semilinear-covariance magma-stable-group

verify-magma-generated:
	@$(PYTHON) scripts/emit_magma_suite.py --check

magma-vertical-different: verify-magma-generated
	@$(MAGMA) -b verification/magma/certify_p23_vertical_different.m

magma-tame-resolvents: verify-magma-generated
	@$(MAGMA) -b verification/magma/certify_p23_tame_resolvents.m

magma-semilinear-covariance: verify-magma-generated
	@$(MAGMA) -b verification/magma/certify_p23_semilinear_covariance.m

magma-stable-group: verify-magma-generated
	@$(MAGMA) -b verification/magma/certify_p23_stable_group.m
