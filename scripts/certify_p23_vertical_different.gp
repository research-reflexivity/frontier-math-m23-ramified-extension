\\ Exact first vertical-different certificate at characteristic 23.
\\
\\ Each stable equation has purely inseparable residual degree 23.  Its
\\ ordinary derivative therefore vanishes in the residue field.  Divide the
\\ derivative by the first vertical power (23 for HJLPPZ, pi^4 for Elkies)
\\ and reduce.  The resulting nonzero function is the first vertical
\\ different beneath the Frobenius collapse.

hjlppz_path = getenv("M23_ZETA_HJLPPZ_POLY");
if(type(hjlppz_path) != "t_STR" || #hjlppz_path == 0, error("M23_ZETA_HJLPPZ_POLY is required"));
elkies_path = getenv("M23_ZETA_ELKIES_COVER");
if(type(elkies_path) != "t_STR" || #elkies_path == 0, error("M23_ZETA_ELKIES_COVER is required"));

read(hjlppz_path);
read(elkies_path);
s; z; y; t;

must(flag, message) =
{
  if(!flag,
    print("CERTIFICATE_FAILURE: ", message);
    quit(1)
  )
};

gauss_ideal_valuation(nf, prime_ideal, polynomial, variable, field_polynomial) =
{
  my(minimum = 10^9);
  if(polynomial == 0, return(minimum));
  for(i = 0, poldegree(polynomial,variable),
    my(coefficient = Mod(polcoef(polynomial,i,variable),field_polynomial));
    if(coefficient != 0,
      minimum = min(minimum,idealval(nf,coefficient,prime_ideal))
    )
  );
  return(minimum)
};

reduce_integral_polynomial(nf, prime_ideal, modpr, polynomial, variable, field_polynomial, scale) =
{
  my(reduction = 0);
  for(i = 0, poldegree(polynomial,variable),
    my(coefficient = Mod(polcoef(polynomial,i,variable),field_polynomial)/scale);
    if(coefficient != 0,
      must(idealval(nf,coefficient,prime_ideal) >= 0,
           "attempted to reduce a nonintegral vertical-different coefficient");
      reduction += nfmodpr(nf,coefficient,modpr)*variable^i
    )
  );
  return(reduction)
};

certify_hjlppz_vertical_different() =
{
  my(field_polynomial = s^2+23);
  my(nf = nfinit(field_polynomial));
  my(prime_ideal = idealprimedec(nf,23)[1]);
  my(modpr = nfmodprinit(nf,prime_ideal,'a));
  must(prime_ideal[3] == 2 && prime_ideal[4] == 1,
       "wrong HJ stable quadratic prime profile");
  must(idealval(nf,Mod(23,field_polynomial),prime_ideal) == 2,
       "wrong HJ absolute ramification index");

  \\ The derivative of V^23 contributes 23*V^22.  For k=2,...,22,
  \\ the actual coefficient is b[k]/(T^2+23)^floor(5k/23).
  \\ After T=s*z/(2-z), T^2+23=-92*(z-1)/(2-z)^2.
  my(normalized_derivative = Mod(1,23)*V^22);
  my(coefficient_valuations = vector(21));
  for(k = 2, 22,
    my(denominator_order = (5*k)\23);
    my(numerator = subst(b[k],T,s*z/(2-z)) *
                         (2-z)^(2*denominator_order));
    numerator = lift(simplify(Mod(numerator,field_polynomial)));
    coefficient_valuations[k-1] =
      gauss_ideal_valuation(nf,prime_ideal,numerator,z,field_polynomial)
      - 2*denominator_order;
    must(coefficient_valuations[k-1] >= 2,
         "HJ derivative coefficient has valuation below v(23)");
    if(coefficient_valuations[k-1] == 2,
      my(reduced_numerator = reduce_integral_polynomial(
        nf,prime_ideal,modpr,numerator,z,field_polynomial,
        23*(-92)^denominator_order
      ));
      normalized_derivative += (23-k)*reduced_numerator /
        (Mod(1,23)*(z-1)^denominator_order) * V^(22-k)
    )
  );
  normalized_derivative = simplify(normalized_derivative);
  must(coefficient_valuations ==
    [4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],
    "wrong HJ stable derivative coefficient valuations");
  must(poldegree(normalized_derivative,V) == 22 && normalized_derivative != 0,
       "HJ normalized vertical derivative vanished");

  \\ PARI factors the rational scalar (z-1)^-3 and one irreducible
  \\ degree-22 polynomial in V.  This is a useful exact irreducibility gate.
  my(derivative_factors = factor(normalized_derivative));
  must(matsize(derivative_factors)[1] == 2 &&
       derivative_factors[1,1] == Mod(1,23)*(z-1) &&
       derivative_factors[1,2] == -3 &&
       poldegree(derivative_factors[2,1],V) == 22 &&
       derivative_factors[2,2] == 1,
       "wrong HJ normalized derivative factorization");

  my(endpoint = Mod(1,23) *
    (8*z^9+7*z^8+11*z^7+16*z^6+3*z^5+19*z^4+
     21*z^3+21*z^2+17*z+15));
  my(residual_constant = endpoint/(Mod(1,23)*(z-1)^5));
  my(residual_polynomial = V^23+residual_constant);
  must(deriv(residual_constant,z) != 0,
       "HJ residual polynomial is not purely inseparable irreducible");

  \\ The norm of the first vertical different has a small exact divisor.
  my(different_norm = simplify(polresultant(
    residual_polynomial,normalized_derivative,V
  )));
  my(tail_quadratic = Mod(1,23)*(z^2+13*z+10));
  my(expected_norm = z^30*(z-2)^102*tail_quadratic^22/(z-1)^88);
  must(different_norm == expected_norm,
       "wrong HJ first vertical-different norm");
  must(polisirreducible(tail_quadratic),
       "HJ quadratic vertical-different locus unexpectedly split");

  \\ After the forced tame value-group extension, the wild C23 extension
  \\ is fierce.  Its different has normalized valuation 1, hence its unique
  \\ lower break is 1/22 and its Wewers--Kato upper break is 23/22.  Formula
  \\ (5) in Wewers has an essential graded coefficient: for a generator
  \\ sigma of C23 and a residue generator x it is
  \\   rsw(chi)=b^(-1) tensor dlog(N(x)),
  \\   b=N(sigma(x)/x-1).
  \\ This certificate verifies the residual norm differential.  It does not
  \\ replace b by a constant, which would require a separate tame-resolvent
  \\ calculation.
  my(residual_norm_function = -residual_constant);
  my(residual_norm_differential = deriv(residual_norm_function,z) /
                                  residual_norm_function);
  must(residual_norm_differential != 0,
       "HJ residual norm differential vanished");

  \\ Since the residual polynomial is irreducible and the normalized
  \\ derivative is nonzero at its generic root, the monogenic order is a DVR
  \\ and the different valuation is exactly v(23)=2.  Its norm has exponent
  \\ 23*2=46.
  print("hjlppz\t23\tderivative_coefficient_valuations\t4,2x20\tminimum_2");
  print("hjlppz\t23\tnormalized_vertical_derivative\t22\tirreducible_over_F23(z)");
  print("hjlppz\t23\tdifferent_norm_divisor\t0:30,2:102,Q2:22,1:-88,infinity:-88\tQ2=z^2+13z+10_irreducible");
  print("hjlppz\t23\tmonogenic_different_exponent\t2\tnormalized_derivative_nonzero");
  print("hjlppz\t23\tdiscriminant_exponent\t46\t23_times_different");
  print("hjlppz\t23\twild_upper_break\t23/22\tmaximal_fierce_C23_break");
  print("hjlppz\t23\tresidual_norm_differential\tdlog(-E(z)/(z-1)^5)\tCartier_fixed");
  print("hjlppz\t23\trefined_swan_normalization\tb_H^(-1)_tensor_residual_norm_differential\tb_H=N(sigma(x)/x-1)_required")
};

certify_elkies_vertical_different() =
{
  my(nf = nfinit(q_elkies));
  my(prime_ideal = idealprimedec(nf,23)[1]);
  my(modpr = nfmodprinit(nf,prime_ideal,'a));
  my(uniformizer = Mod(g+6,q_elkies));
  my(tauK = Mod(tau_elkies,q_elkies));
  must(prime_ideal[3] == 4 && prime_ideal[4] == 1 &&
       idealval(nf,uniformizer,prime_ideal) == 1 &&
       idealval(nf,Mod(23,q_elkies),prime_ideal) == 4,
       "wrong Elkies local profile or uniformizer");

  my(scaled_map = subst(P_elkies,x,uniformizer^(-1)*y)/tauK);
  my(normalized_derivative = deriv(scaled_map,y)/uniformizer^4);
  my(derivative_valuations = vector(23));
  my(reduced_derivative = 0);
  for(k = 0, 22,
    my(coefficient = Mod(polcoef(normalized_derivative,k,y),q_elkies));
    derivative_valuations[k+1] = idealval(nf,coefficient,prime_ideal);
    must(derivative_valuations[k+1] >= 0,
         "Elkies normalized derivative is not integral");
    if(coefficient != 0,
      reduced_derivative += nfmodpr(nf,coefficient,modpr)*y^k
    )
  );
  must(derivative_valuations ==
    [7,7,6,6,5,5,4,4,3,3,2,2,1,1,0,0,0,0,0,0,0,0,0],
    "wrong Elkies normalized derivative valuations");
  my(expected_derivative = Mod(-1,23)*y^14*(y-9)^8);
  must(reduced_derivative == expected_derivative,
       "wrong Elkies first vertical derivative");

  my(residual_polynomial = Mod(18,23)*y^23-t);
  my(different_norm = polresultant(
    residual_polynomial,reduced_derivative,y
  ));
  must(different_norm == Mod(-1,23)*t^14*(t-1)^8,
       "wrong Elkies first vertical-different norm");

  my(residual_norm_function = t/Mod(18,23));
  my(residual_norm_differential = deriv(residual_norm_function,t) /
                                  residual_norm_function);
  must(residual_norm_differential == 1/t,
       "wrong Elkies residual norm differential");

  \\ The same DVR argument gives different exponent v(23)=4 and
  \\ discriminant exponent 23*4=92.
  print("elkies\t23\tderivative_coefficient_valuations\t7,7,6,6,5,5,4,4,3,3,2,2,1,1,0x9\tminimum_0_after_pi4");
  print("elkies\t23\tnormalized_vertical_derivative\t-y^14*(y-9)^8\ttail_centers_0,9");
  print("elkies\t23\tdifferent_norm_divisor\t0:14,1:8,infinity:-22\trecovers_4A,2A_contributions");
  print("elkies\t23\tmonogenic_different_exponent\t4\tnormalized_derivative_nonzero");
  print("elkies\t23\tdiscriminant_exponent\t92\t23_times_different");
  print("elkies\t23\twild_upper_break\t23/22\tmaximal_fierce_C23_break");
  print("elkies\t23\tresidual_norm_differential\tdt/t\tCartier_fixed");
  print("elkies\t23\trefined_swan_normalization\tb_E^(-1)_tensor_residual_norm_differential\tb_E=N(sigma(x)/x-1)_required")
};

print("cover\tprime\tinvariant\tvalue\tstatus");
certify_hjlppz_vertical_different();
certify_elkies_vertical_different();
print("# PASS_CHARACTERISTIC_23_VERTICAL_DIFFERENT_CERTIFICATE");
quit(0);
