Copyright 2024-2025, Damir Yunusov, Ilhom Kombaev
SPDX-License-Identifier: LGPL-3.0-or-later

  $ ../bin/REPL.exe -dparsetree <<EOF
  > 2 * 2
  Parsed result: (Pstr_eval
                    (Pexp_apply ((Pexp_ident "*"),
                       [(Pexp_constant (Pconst_int 2));
                         (Pexp_constant (Pconst_int 2))]
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > 2 * ((2 * (124 * homka))) * (((2 * 1)))
  Parsed result: (Pstr_eval
                    (Pexp_apply ((Pexp_ident "*"),
                       [(Pexp_apply ((Pexp_ident "*"),
                           [(Pexp_constant (Pconst_int 2));
                             (Pexp_apply ((Pexp_ident "*"),
                                [(Pexp_constant (Pconst_int 2));
                                  (Pexp_apply ((Pexp_ident "*"),
                                     [(Pexp_constant (Pconst_int 124));
                                       (Pexp_ident "homka")]
                                     ))
                                  ]
                                ))
                             ]
                           ));
                         (Pexp_apply ((Pexp_ident "*"),
                            [(Pexp_constant (Pconst_int 2));
                              (Pexp_constant (Pconst_int 1))]
                            ))
                         ]
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > 2 * ((2 / (124 / homka))) * (1) * (2 / 2) * (((2 * 1)))
  Parsed result: (Pstr_eval
                    (Pexp_apply ((Pexp_ident "*"),
                       [(Pexp_apply ((Pexp_ident "*"),
                           [(Pexp_apply ((Pexp_ident "*"),
                               [(Pexp_apply ((Pexp_ident "*"),
                                   [(Pexp_constant (Pconst_int 2));
                                     (Pexp_apply ((Pexp_ident "/"),
                                        [(Pexp_constant (Pconst_int 2));
                                          (Pexp_apply ((Pexp_ident "/"),
                                             [(Pexp_constant (Pconst_int 124));
                                               (Pexp_ident "homka")]
                                             ))
                                          ]
                                        ))
                                     ]
                                   ));
                                 (Pexp_constant (Pconst_int 1))]
                               ));
                             (Pexp_apply ((Pexp_ident "/"),
                                [(Pexp_constant (Pconst_int 2));
                                  (Pexp_constant (Pconst_int 2))]
                                ))
                             ]
                           ));
                         (Pexp_apply ((Pexp_ident "*"),
                            [(Pexp_constant (Pconst_int 2));
                              (Pexp_constant (Pconst_int 1))]
                            ))
                         ]
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > fun x -> 5
  Parsed result: (Pstr_eval
                    (Pexp_fun ((Ppat_var "x"), (Pexp_constant (Pconst_int 5)))))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > fun x -> fun y -> fun z -> 5
  Parsed result: (Pstr_eval
                    (Pexp_fun ((Ppat_var "x"),
                       (Pexp_fun ((Ppat_var "y"),
                          (Pexp_fun ((Ppat_var "z"),
                             (Pexp_constant (Pconst_int 5))))
                          ))
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > fun x y z -> 5
  Parsed result: (Pstr_eval
                    (Pexp_fun ((Ppat_var "x"),
                       (Pexp_fun ((Ppat_var "y"),
                          (Pexp_fun ((Ppat_var "z"),
                             (Pexp_constant (Pconst_int 5))))
                          ))
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > if x then y else z
  Parsed result: (Pstr_eval
                    (Pexp_ifthenelse ((Pexp_ident "x"), (Pexp_ident "y"),
                       (Some (Pexp_ident "z")))))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > if x then if y then z
  Parsed result: (Pstr_eval
                    (Pexp_ifthenelse ((Pexp_ident "x"),
                       (Pexp_ifthenelse ((Pexp_ident "y"), (Pexp_ident "z"),
                          None)),
                       None)))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > 2 * if true then 2 else 1
  Parsed result: (Pstr_eval
                    (Pexp_apply ((Pexp_ident "*"),
                       [(Pexp_constant (Pconst_int 2));
                         (Pexp_ifthenelse (
                            (Pexp_constant (Pconst_boolean true)),
                            (Pexp_constant (Pconst_int 2)),
                            (Some (Pexp_constant (Pconst_int 1)))))
                         ]
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > fun x y -> if x then y
  Parsed result: (Pstr_eval
                    (Pexp_fun ((Ppat_var "x"),
                       (Pexp_fun ((Ppat_var "y"),
                          (Pexp_ifthenelse ((Pexp_ident "x"), (Pexp_ident "y"),
                             None))
                          ))
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > fun x -> fun y -> if x then y else x
  Parsed result: (Pstr_eval
                    (Pexp_fun ((Ppat_var "x"),
                       (Pexp_fun ((Ppat_var "y"),
                          (Pexp_ifthenelse ((Pexp_ident "x"), (Pexp_ident "y"),
                             (Some (Pexp_ident "x"))))
                          ))
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > f y z
  Parsed result: (Pstr_eval
                    (Pexp_apply ((Pexp_ident "f"),
                       [(Pexp_ident "y"); (Pexp_ident "z")])))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > let homka = 5 in homka
  Parsed result: (Pstr_eval
                    (Pexp_let (NonRecursive,
                       [{ pvb_pat = (Ppat_var "homka");
                          pvb_expr = (Pexp_constant (Pconst_int 5)) }
                         ],
                       (Pexp_ident "homka"))))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > let homka = fun x -> x + 2 in homka
  Parsed result: (Pstr_eval
                    (Pexp_let (NonRecursive,
                       [{ pvb_pat = (Ppat_var "homka");
                          pvb_expr =
                          (Pexp_fun ((Ppat_var "x"),
                             (Pexp_apply ((Pexp_ident "+"),
                                [(Pexp_ident "x");
                                  (Pexp_constant (Pconst_int 2))]
                                ))
                             ))
                          }
                         ],
                       (Pexp_ident "homka"))))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > let reca = 5
  Parsed result: (Pstr_value (NonRecursive,
                    [{ pvb_pat = (Ppat_var "reca");
                       pvb_expr = (Pexp_constant (Pconst_int 5)) }
                      ]
                    ))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > (5+5, fun homka x -> 5, "looool")
  Parsed result: (Pstr_eval
                    (Pexp_tuple
                       [(Pexp_apply ((Pexp_ident "+"),
                           [(Pexp_constant (Pconst_int 5));
                             (Pexp_constant (Pconst_int 5))]
                           ));
                         (Pexp_fun ((Ppat_var "homka"),
                            (Pexp_fun ((Ppat_var "x"),
                               (Pexp_tuple
                                  [(Pexp_constant (Pconst_int 5));
                                    (Pexp_constant (Pconst_string "looool"))])
                               ))
                            ))
                         ]))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > (let x = 5 in 4, x)
  Parsed result: (Pstr_eval
                    (Pexp_let (NonRecursive,
                       [{ pvb_pat = (Ppat_var "x");
                          pvb_expr = (Pexp_constant (Pconst_int 5)) }
                         ],
                       (Pexp_tuple
                          [(Pexp_constant (Pconst_int 4)); (Pexp_ident "x")])
                       )))

  $ ../bin/REPL.exe -dparsetree <<EOF
  > let x = (1, 2, 3)
  Parsed result: (Pstr_value (NonRecursive,
                    [{ pvb_pat = (Ppat_var "x");
                       pvb_expr =
                       (Pexp_tuple
                          [(Pexp_constant (Pconst_int 1));
                            (Pexp_constant (Pconst_int 2));
                            (Pexp_constant (Pconst_int 3))])
                       }
                      ]
                    ))
