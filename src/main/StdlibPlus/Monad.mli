open Higher.Syntax
open Misc.Syntax

type ('f, 'a, 'b) bind =
  ('a -> ('f, 'b) app'1) -> ('f, 'a) app'1 -> ('f, 'b) app'1

type 'f t = < 'f Applicative.t ; bind : 'a 'b. ('f, 'a, 'b) bind >
type ('f, 'a, 'D) fr = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'a, 'f t) fr

module Syntax : sig
  val ( let* ) : ('f, 'a, 'D) fr -> ('a -> ('f, 'b, 'D) fr) -> ('f, 'b, 'D) fr
  val ( and* ) : ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr -> ('f, 'a * 'b, 'D) fr

  (* *)

  val ( >>= ) : ('f, 'a, 'D) fr -> ('a -> ('f, 'b, 'D) fr) -> ('f, 'b, 'D) fr
  val ( >> ) : ('f, unit, 'D) fr -> ('f, 'a, 'D) fr -> ('f, 'a, 'D) fr

  val ( >=> ) :
    ('a -> ('f, 'b, 'D) fr) -> ('b -> ('f, 'c, 'D) fr) -> 'a -> ('f, 'c, 'D) fr

  (* *)

  val ( ||| ) : ('f, bool, 'D) fr bop
  val ( &&& ) : ('f, bool, 'D) fr bop

  (* *)

  val delay : (unit -> ('f, 'a, 'D) fr) -> ('f, 'a, 'D) fr
end
