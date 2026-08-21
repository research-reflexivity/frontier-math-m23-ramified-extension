# Third-party notices

The repository's Apache-2.0, CC BY-NC-SA 4.0, and CC0 declarations apply only to
rights held by Reflexivity, Inc. They do not relicense third-party materials or
claim ownership of uncopyrightable mathematical facts.

## GAP

The finite-group certificate invokes GAP as an external runtime dependency.
The local development environment uses GAP 4.16.0. GAP and its standard
packages are distributed under the GNU General Public License, version 2 or,
at the user's option, any later version (`GPL-2.0-or-later`). GAP is not bundled
in this repository.

- GAP: https://www.gap-system.org/
- License: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html

## PARI/GP

The arithmetic certificates invoke PARI/GP as an external runtime dependency.
The local development environment uses PARI/GP 2.17.4. PARI/GP is copyright
the PARI Group and is distributed under `GPL-2.0-or-later`. It is not bundled
in this repository.

- PARI/GP: https://pari.math.u-bordeaux.fr/
- License: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html

## Magma

The optional second certificate suite invokes Magma as an external runtime
dependency. The recorded runs used Magma V2.29-9 on the University of Sydney
public calculator. Magma is proprietary software and is not bundled in this
repository.

- Magma: https://magma.maths.usyd.edu.au/magma/
- Public calculator: https://magma.maths.usyd.edu.au/calc/

## Huang-Jackson-Lee-Poonen-Pries-Zhang cover

The regular M23-extension, published degree-23 equation, branch-cycle
description, and source theorem are due to:

X. Huang, B. Jackson, K.-H. Lee, B. Poonen, R. Pries, and S. Zhang,
*The Mathieu group M23 is a Galois group over Q*, arXiv:2608.08538 (2026).

The authors' data repository is:

https://github.com/shaowuz/m23isgalois

The included `families/hjlppz-2026/polynomial_F.gp` is the upstream file from
commit `f9c59eba2017090c5ea20f6f4e4a412055443463`. At the time this notice was
prepared, that external repository did not provide an explicit software
license. No license grant for its source code is implied here.

## Elkies cover

The independent polynomial cover and displayed exact formulas transcribed in
`families/elkies-2013/elkies_cover.gp` are due to:

N. D. Elkies, *The complex polynomials P(x) with Gal(P(x)-t) isomorphic to
M23*, Open Book Series 1 (2013), 359-368.

- DOI: https://doi.org/10.2140/obs.2013.1.359

The CC0 dedication covers only rights held by Reflexivity in its transcription
or computational arrangement. It does not relicense Elkies's publication.
