\\ Exact Elkies degree-23 polynomial cover over a quartic field.
\\
\\ F = Q[g]/(q_elkies), P = P2^2 P3 P4^4, B = P/tau.
\\ The finite branch values of B are 0 and 1.

q_elkies = g^4 + g^3 + 9*g^2 - 10*g + 8;

P2_elkies = (8*g^3 + 16*g^2 - 20*g + 20)*x^2 - (7*g^3 + 17*g^2 - 7*g + 76)*x - 13*g^3 + 25*g^2 - 107*g + 596;

P3_elkies = 8*(31*g^3 + 405*g^2 - 459*g + 333)*x^3 + (941*g^3 + 1303*g^2 - 1853*g + 1772)*x + 85*g^3 - 385*g^2 + 395*g - 220;

P4_elkies = 32*(4*g^3 - 69*g^2 + 74*g - 49)*x^4 + 32*(21*g^3 + 53*g^2 - 68*g + 58)*x^3 - 8*(97*g^3 + 95*g^2 - 145*g + 148)*x^2 + 8*(41*g^3 - 89*g^2 - g + 140)*x - 123*g^3 + 391*g^2 - 93*g + 3228;

tau_elkies = (2^38 * 3^17 / 23^3) * (47323*g^3 - 1084897*g^2 + 7751*g - 711002);

P_elkies = P2_elkies^2 * P3_elkies * P4_elkies^4;
B_elkies = P_elkies / tau_elkies;
