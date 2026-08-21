# Magma verification suite

These four self-contained certificates reimplement the paper's three
PARI/GP streams and one GAP stream in Magma:

- `certify_p23_vertical_different.m` checks both first vertical derivatives,
  their valuation profiles and norms, and the residual norm differentials.
- `certify_p23_tame_resolvents.m` checks the oriented discriminant square
  roots, degree-11 Kummer parameters, initial units, and root norms.
- `certify_p23_semilinear_covariance.m` checks the branch-exchange identities,
  quotient quartic, critical passport, Shabat form, and packet reversal.
- `certify_p23_stable_group.m` constructs the natural degree-23 copy of
  M23 and checks the normalizer, centralizer, and conjugation packets in M23
  and S23.

Run all four with `make verify-magma`, or paste any individual file into the
[University of Sydney public Magma calculator](https://magma.maths.usyd.edu.au/calc/).
Every input is below 15 KB. A failed assertion prints `CERTIFICATE_FAILURE`
and terminates before the final PASS marker.

The two arithmetic inputs are generated from the exact `.gp` cover definitions
by `scripts/emit_magma_suite.py`. Run that script with `--check` to confirm the
checked-in Magma files are current. The semilinear and group certificates are
standalone fixed templates emitted by the same generator.

This is an independent implementation and runtime check of the exact
computational identities. It does not replace the mathematical arguments that
deduce the ramification theorem from those identities.
