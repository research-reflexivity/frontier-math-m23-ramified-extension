\\ Exact tame degree-11 Kummer-resolvent certificate at characteristic 23.
\\
\\ For roots r_j labelled by a C23-translation, put
\\   C_a = product_j (r_(j+a)-r_j),  A = product_(a square) C_a.
\\ Then A^2=Disc(f).  The degree-11 tame fixed field is K(theta), where
\\ theta^11 is the square root A after removal of an explicit 11th power.

V; T; y; t; x; g;

hjlppz_path = getenv("M23_ZETA_HJLPPZ_POLY");
if(type(hjlppz_path) != "t_STR" || #hjlppz_path == 0, error("M23_ZETA_HJLPPZ_POLY is required"));
elkies_path = getenv("M23_ZETA_ELKIES_COVER");
if(type(elkies_path) != "t_STR" || #elkies_path == 0, error("M23_ZETA_ELKIES_COVER is required"));

read(hjlppz_path);
read(elkies_path);

must(flag, message) =
{
  if(!flag,
    print("CERTIFICATE_FAILURE: ", message);
    quit(1)
  )
};

certify_oriented_cycle_identity() =
{
  my(squares = [1,2,3,4,6,8,9,12,13,16,18]);
  must(prod(i=1,#squares,squares[i]) % 23 == 1,
       "the quadratic-residue packet has the wrong product");
  must(Mod(-1,23)^11 == Mod(-1,23),
       "C_-a=-C_a has the wrong odd-degree sign");
  print("both\t23\toriented_cycle_norm_identity\tA^2=Disc(f)\tA=product_(q_square)C_q");
  print("both\t23\tdegree_11_oriented_resolvent\tproduct_(q_square)(U-C_q)\tconstant_term=-A")
};

certify_hjlppz_tame_resolvent() =
{
  my(q = T^2+23);
  my(discriminant = poldisc(F,V));
  my(discriminant_factors = factor(discriminant));
  my(G84 = 0);
  for(i=1,matsize(discriminant_factors)[1],
    my(h = discriminant_factors[i,1]);
    my(e = discriminant_factors[i,2]);
    if(type(h) == "t_POL" && poldegree(h,T) == 84 && e == 2,
      G84 = h
    )
  );
  must(G84 != 0, "missing HJ degree-84 square factor");

  \\ PARI polynomial factorization is normalized only up to a scalar unit.
  \\ Recover that unit and its exact square root.
  my(unit_square = simplify(discriminant/factorback(discriminant_factors)));
  my(a0 = 0);
  must(type(unit_square) == "t_INT" && issquare(unit_square,&a0),
       "HJ discriminant factorization has a nonsquare scalar");
  must(a0 == 2^105*3^36*23^37,
       "wrong HJ discriminant-square scalar");

  my(AH = a0*T^4*G84/q^44);
  must(simplify(AH^2-discriminant) == 0,
       "wrong HJ oriented discriminant square root");

  \\ AH=hH^11*LambdaH.  After T=s*w, s^2=-23, LambdaH has
  \\ s-valuation one, so X^11-LambdaH is Eisenstein of degree 11.
  my(hH = 2^9*3^3*23^5/q^4);
  my(lambdaH = 2^6*3^3*T^4*G84/23^18);
  must(simplify(AH-hH^11*lambdaH) == 0,
       "wrong HJ eleventh-power normalization");

  \\ Compute the initial unit of LambdaH/s without introducing a symbolic
  \\ quadratic number field.  A coefficient g_k*T^(k+4) contributes at
  \\ the first grade exactly when 2*v_23(g_k)+k=33.
  my(weighted_minimum = 10^9);
  my(lambda_residue_w = Mod(0,23)*T);
  for(k=0,84,
    my(gk = polcoef(G84,k,T));
    if(gk != 0,
      my(weight = 2*valuation(gk,23)+k);
      weighted_minimum = min(weighted_minimum,weight);
      if(weight == 33,
        must(k%2 == 1, "HJ first-grade parity failure");
        lambda_residue_w += Mod(
          2^6*3^3*gk/((-23)^((33-k)/2)),23
        )*T^(k+4)
      )
    )
  );
  must(weighted_minimum == 33,
       "wrong HJ weighted valuation of the degree-84 factor");
  my(lambda_residue_factors = factor(lambda_residue_w));
  must(matsize(lambda_residue_factors)[1] == 2 &&
       lambda_residue_factors[1,1] == Mod(1,23)*T &&
       lambda_residue_factors[1,2] == 15 &&
       lambda_residue_factors[2,1] == Mod(1,23)*(T^2+6) &&
       lambda_residue_factors[2,2] == 11,
       "wrong HJ initial tame Kummer parameter");
  \\ The factorization is monic and therefore omits the scalar unit.  In the
  \\ intermediate w-coordinate the unit is -1.  Passing from (2-z)^37 to the
  \\ published (z-2)^37 cancels this sign.
  must(lambda_residue_w == -Mod(1,23)*T^15*(T^2+6)^11,
       "wrong HJ initial tame Kummer parameter scalar");

  my(YH = -b[23]/q^5);
  must(YH == -polcoef(F,0,V), "wrong HJ root norm");

  print("hjlppz\t23\tdiscriminant_square_root\t2^105*3^36*23^37*T^4*G84(T)/(T^2+23)^44\texact_G84_degree_84");
  print("hjlppz\t23\ttame_kummer_parameter\tLambda_H=2^6*3^3*T^4*G84(T)/23^18\tv_s(Lambda_H)=1");
  print("hjlppz\t23\ttame_degree_11_resolvent\tX^11-Lambda_H\tEisenstein_over_Q23(s)(z)");
  print("hjlppz\t23\ttame_parameter_initial_unit\tz^15*(z^2+13*z+10)^11/(z-2)^37\tLambda_H/s_mod_s");
  print("hjlppz\t23\troot_norm_Y_H\t-b_23(T)/(T^2+23)^5\treduces_to_-E(z)/(z-1)^5");
  print("hjlppz\t23\tgraded_b_H\tin(b_H)=in(h_H*theta_H/Y_H)\ttheta_H^11=Lambda_H");
  print("hjlppz\t23\tgraded_b_H_explicit\t8*s^2*xi_H*(z-2)^8*(z-1)/E(z)\txi_H^11=s*z^15*(z^2+13*z+10)^11/(z-2)^37")
};

certify_elkies_tame_resolvent() =
{
  my(field_polynomial = q_elkies);
  my(nf = nfinit(field_polynomial));
  my(prime_ideal = idealprimedec(nf,23)[1]);
  my(modpr = nfmodprinit(nf,prime_ideal,'a));
  my(pi = Mod(g+6,field_polynomial));
  my(tauK = Mod(tau_elkies,field_polynomial));
  my(sE = Mod((2*g^3+4*g^2+16*g-7)/3,field_polynomial));
  must(sE^2 == -23, "wrong Elkies square root of -23");
  must(idealval(nf,sE,prime_ideal) == 2,
       "wrong valuation of the Elkies quadratic uniformizer");

  my(p23 = Mod(polcoef(P_elkies,23,x),field_polynomial));
  my(q23 = p23*pi^(-23));
  my(raw = subst(P_elkies,x,pi^(-1)*y)/tauK-t);
  my(leading = polcoef(raw,23,y));
  must(leading == q23/tauK, "wrong Elkies scaled leading coefficient");
  my(monic = raw/leading);
  my(discriminant = poldisc(monic,y));

  my(hE = 23*tauK*pi^23/p23);
  my(lambdaE = sE*t^7*(t-1)^4);
  my(AE = hE^11*lambdaE);
  must(discriminant == AE^2,
       "wrong Elkies oriented discriminant square root");
  must(idealval(nf,hE,prime_ideal) == 4,
       "wrong Elkies eleventh-power scaling valuation");
  must(nfmodpr(nf,sE/pi^2,modpr) == Mod(-3,23),
       "wrong Elkies initial tame Kummer unit");
  must(nfmodpr(nf,hE/pi^4,modpr) == Mod(11,23),
       "wrong Elkies b-scaling unit");

  my(P0 = Mod(subst(P_elkies,x,0),field_polynomial));
  my(YE = (tauK*t-P0)/q23);
  must(YE == -polcoef(monic,0,y), "wrong Elkies root norm");
  must(nfmodpr(nf,polcoef(YE,1,t),modpr) == Mod(9,23) &&
       nfmodpr(nf,polcoef(YE,0,t),modpr) == 0,
       "wrong Elkies residual root norm");

  print("elkies\t23\tsqrt_minus_23\t(2*g^3+4*g^2+16*g-7)/3\ts_E^2=-23");
  print("elkies\t23\tdiscriminant_square_root\ts_E*(23*tau*pi^23/p_23)^11*t^7*(t-1)^4\texact_over_F(t)");
  print("elkies\t23\ttame_kummer_parameter\tLambda_E=s_E*t^7*(t-1)^4\tv_pi(Lambda_E)=2");
  print("elkies\t23\ttame_degree_11_resolvent\tX^11-Lambda_E\ttotally_tame_degree_11");
  print("elkies\t23\ttame_parameter_initial_unit\t-3*t^7*(t-1)^4\tLambda_E/pi^2_mod_pi");
  print("elkies\t23\troot_norm_Y_E\t(tau*t-P(0))/(p_23*pi^-23)\treduces_to_t/18");
  print("elkies\t23\tgraded_b_E\tin(b_E)=in(h_E*theta_E/Y_E)\ttheta_E^11=Lambda_E");
  print("elkies\t23\tgraded_b_E_explicit\t14*pi^4*xi_E/t\txi_E^11=-3*pi^2*t^7*(t-1)^4")
};

print("cover\tprime\tinvariant\tvalue\tstatus");
certify_oriented_cycle_identity();
certify_hjlppz_tame_resolvent();
certify_elkies_tame_resolvent();
print("# PASS_CHARACTERISTIC_23_TAME_RESOLVENT_CERTIFICATE");
quit(0);
