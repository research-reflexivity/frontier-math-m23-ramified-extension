# Exact group certificate for the characteristic-23 stable fiber.

G := MathieuGroup(23);;
P := SylowSubgroup(G, 23);;
N := Normalizer(G, P);;
C := Centralizer(G, P);;
nonidentity := Difference(Elements(P), [One(P)]);;
m23Orbits := List(Orbits(N, nonidentity, OnPoints), Length);;
Sort(m23Orbits);;

generator := First(GeneratorsOfGroup(P), x -> Order(x) = 23);;
exponents := [];;
for n in Elements(N) do
  conjugate := generator ^ n;
  for a in [1..22] do
    if generator ^ a = conjugate then
      AddSet(exponents, a);
      break;
    fi;
  od;
od;
squares := Set([1..22], a -> (a * a) mod 23);;

S := SymmetricGroup(23);;
NS := Normalizer(S, P);;
CS := Centralizer(S, P);;
s23Orbits := List(Orbits(NS, nonidentity, OnPoints), Length);;
Sort(s23Orbits);;

if Size(G) <> 10200960 or Size(P) <> 23 or Size(N) <> 253 or
   Size(C) <> 23 or m23Orbits <> [11, 11] or exponents <> squares or
   Size(NS) <> 506 or Size(CS) <> 23 or s23Orbits <> [22] then
  Error("characteristic-23 stable group certificate failed");
fi;

Print("group\tinvariant\tvalue\tstatus\n");
Print("M23\torder\t", Size(G), "\texact\n");
Print("M23\tC23_normalizer_order\t", Size(N), "\t23:11\n");
Print("M23\tC23_centralizer_order\t", Size(C), "\tC23\n");
Print("M23\tnontrivial_C23_orbits\t11,11\ttwo_oriented_packets\n");
Print("M23\tnormalizer_exponents\t", JoinStringsWithSeparator(List(exponents, String), ","), "\tnonzero_squares_mod_23\n");
Print("S23\tC23_normalizer_order\t", Size(NS), "\t23:22\n");
Print("S23\tnontrivial_C23_orbits\t22\tpackets_fused\n");
Print("# PASS_CHARACTERISTIC_23_STABLE_GROUP_CERTIFICATE\n");
QUIT;
