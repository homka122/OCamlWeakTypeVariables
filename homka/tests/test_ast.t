Copyright 2024-2025, Damir Yunusov, Ilhom Kombaev
SPDX-License-Identifier: LGPL-3.0-or-later

  $ ../bin/damir.exe
  (Binding ("factorial", Recursive, ["n"],
     (Op_tern (IfThenElse, (Op_bin (Equal, (Variable "n"), (Const (Int 0)))),
        (Const (Int 1)),
        (Op_bin (Mul, (Variable "n"),
           (Function ("factorial",
              [(Op_bin (Minus, (Variable "n"), (Const (Int 1))))]))
           ))
        ))
     ))
