open Higher.Syntax
open Functor.Syntax

class virtual ['f] t =
  object
    inherit ['f] Functor.t
    method virtual return : 'a. ('f, 'a) Method.return
    method virtual pair : 'a 'b. ('f, 'a, 'b) Method.pair
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let return x : (_, _, _) r = fun f -> f#return x
  let ( and+ ) xM yM : (_, _, _) r = fun f -> f#pair (xM f) (yM f)

  (* *)

  let ( <*> ) = ( and+ )

  (* *)

  let tuple'2 = ( and+ )

  let tuple'3 x1M x2M x3M =
    let+ x1 = x1M and+ x2 = x2M and+ x3 = x3M in
    (x1, x2, x3)

  let tuple'4 x1M x2M x3M x4M =
    let+ x1 = x1M and+ x2 = x2M and+ x3 = x3M and+ x4 = x4M in
    (x1, x2, x3, x4)

  let tuple'5 x1M x2M x3M x4M x5M =
    let+ x1 = x1M and+ x2 = x2M and+ x3 = x3M and+ x4 = x4M and+ x5 = x5M in
    (x1, x2, x3, x4, x5)

  let tuple'6 x1M x2M x3M x4M x5M x6M =
    let+ x1 = x1M
    and+ x2 = x2M
    and+ x3 = x3M
    and+ x4 = x4M
    and+ x5 = x5M
    and+ x6 = x6M in
    (x1, x2, x3, x4, x5, x6)

  (* *)

  let unit : (_, _, _) r = fun f -> f#return ()
  let do_unless c uM = if c then unit else uM
  let do_when c uM = if c then uM else unit

  (* *)

  let lift2 xyz x y = x <*> y >>- fun (x, y) -> xyz x y

  (* *)

  let thunk u2x = unit >>- u2x
end
