# Wild Ramification and Refined Swan Conductors at 23 in Two Explicit Degree-23 M23-Covers

Companion certificates for the paper
[Wild Ramification and Refined Swan Conductors at 23 in Two Explicit Degree-23 M23-Covers](pdf/LeLay_M23_Wild_Ramification23.pdf)
by François Le Lay (Reflexivity).

This repository is
<https://github.com/research-reflexivity/frontier-math-m23-ramified-extension>.

It contains the exact PARI/GP and GAP certificates for the paper's local
ramification theorem at 23, together with a second implementation of all four
certificate streams in Magma. The two independent cover definitions are
included because the arithmetic certificates load them directly.

## Reproduce

You need [PARI/GP](https://pari.math.u-bordeaux.fr/) and
[GAP](https://www.gap-system.org/) on `PATH` as `gp` and `gap`. The certificates
were developed against PARI/GP 2.17.4 and GAP 4.16.0.

```sh
make verify
```

The optional Magma suite is self-contained and deterministically generated
from the same fixed cover inputs. With a licensed Magma executable, run

```sh
make verify-magma MAGMA=/path/to/magma
```

Each of the four generated `.m` files is also below the public calculator's
50,000-byte input limit and runs within its 60-second limit. They were checked
with Magma V2.29-9 on the
[University of Sydney calculator](https://magma.maths.usyd.edu.au/calc/).
The exact hashes, seeds, timings, and PASS markers are recorded in
[`verification/magma_verification_summary.json`](verification/magma_verification_summary.json).
Use `make verify-all` when PARI/GP, GAP, and Magma are all available.

The individual certificate streams can be checked against the SHA-256 digests
printed in the paper:

```sh
make vertical-different | shasum -a 256
make tame-resolvents    | shasum -a 256
make semilinear-covariance | shasum -a 256
make stable-group       | shasum -a 256
```

## Layout

- `pdf/` - the publication PDF
- `scripts/` - three exact PARI/GP certificates and one exact GAP certificate
- `families/` - the two fixed cover definitions loaded by the PARI/GP scripts
- `verification/magma/` - four self-contained generated Magma certificates
- `verification/magma_verification_summary.json` - recorded public-calculator runs

## Licensing

Copyright 2026 Reflexivity, Inc.

- Software and certificate scripts: [Apache License 2.0](LICENSE)
- This README, third-party notices, and the PDF: [CC BY-NC-SA 4.0](LICENSE-CC-BY-NC-SA-4.0)
- Original generated or transcribed data in `families/`: [CC0 1.0](LICENSE-CC0-1.0), only to the extent Reflexivity holds the relevant rights

These licenses do not relicense third-party mathematical models or source
material. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
