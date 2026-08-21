// Exact group certificate for the characteristic-23 stable fiber.

procedure Must(flag, message)
    if not flag then
        print "CERTIFICATE_FAILURE: " cat message;
        quit;
    end if;
end procedure;

S := Sym(23);
gA := S!(1,2)(3,4)(7,8)(9,10)(13,14)(15,16)(19,20)(21,22);
gB := S!(1,16,11,3)(2,9,21,12)(4,5,8,23)(6,22,14,18)(13,20)(15,17);
G := sub<S | gA, gB>;
P := SylowSubgroup(G, 23);
N := Normalizer(G, P);
C := Centralizer(G, P);
sigma := Rep({ element : element in P | Order(element) eq 23 });

function ConjugationExponents(group, generator)
    values := {};
    for element in group do
        conjugate := generator^element;
        for exponent in [1..22] do
            if generator^exponent eq conjugate then
                Include(~values, exponent);
                break;
            end if;
        end for;
    end for;
    return values;
end function;

exponents := ConjugationExponents(N, sigma);
squares := { (index^2) mod 23 : index in [1..22] };
NS := Normalizer(S, P);
CS := Centralizer(S, P);
s23_exponents := ConjugationExponents(NS, sigma);
Must(#G eq 10200960 and #P eq 23 and #N eq 253 and #C eq 23,
     "wrong M23 local subgroup orders");
Must(exponents eq squares and #exponents eq 11,
     "M23 conjugation exponents are not the nonzero squares mod 23");
Must(#NS eq 506 and #CS eq 23 and s23_exponents eq {1..22},
     "wrong S23 local subgroup data");

exponent_sequence := Sort(Setseq(exponents));
print "group\tinvariant\tvalue\tstatus";
print "M23\torder\t10200960\texact";
print "M23\tC23_normalizer_order\t253\t23:11";
print "M23\tC23_centralizer_order\t23\tC23";
print "M23\tnontrivial_C23_orbits\t11,11\ttwo_oriented_packets";
printf "M23\tnormalizer_exponents\t%o\tnonzero_squares_mod_23\n",
       Join([ IntegerToString(value) : value in exponent_sequence ], ",");
print "S23\tC23_normalizer_order\t506\t23:22";
print "S23\tnontrivial_C23_orbits\t22\tpackets_fused";
print "# PASS_CHARACTERISTIC_23_STABLE_GROUP_MAGMA_CERTIFICATE";
