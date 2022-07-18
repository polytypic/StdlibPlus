open Higher.Syntax
open Applicative.Syntax

type ('f, 'a, 'b) bind =
  ('a -> ('f, 'b) app'1) -> ('f, 'a) app'1 -> ('f, 'b) app'1

type 'f t = < 'f Applicative.t ; bind : 'a 'b. ('f, 'a, 'b) bind >
type ('f, 'a, 'D) fr = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'a, 'f t) fr

module Syntax = struct
  let ( let* ) xM xyM : (_, _, _) fr =
   fun f -> xM f |> f#bind (fun x -> xyM x f)

  let ( and* ) xM yM : (_, _, _) fr = fun f -> f#pair (xM f) (yM f)

  (* *)

  let ( >>= ) = ( let* )
  let ( >> ) uM xM = uM >>= fun () -> xM
  let ( >=> ) abM bcM a = abM a >>= bcM

  (* *)

  let ( &&& ) lhs rhs = lhs >>= fun lhs -> if lhs then rhs else return false
  let ( ||| ) lhs rhs = lhs >>= fun lhs -> if lhs then return true else rhs

  (* *)

  let delay uxM = unit >>= uxM
end
