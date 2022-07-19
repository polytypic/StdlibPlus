open Higher.Syntax
open Misc.Syntax

type ('f, 'a, 'b) bind =
  ('a -> ('f, 'b) app'1) -> ('f, 'a) app'1 -> ('f, 'b) app'1

type 'f t = < 'f Applicative.t ; bind : 'a 'b. ('f, 'a, 'b) bind >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val ( let* ) : ('f, 'a, 'D) r -> ('a -> ('f, 'b, 'D) r) -> ('f, 'b, 'D) r
  val ( and* ) : ('f, 'a, 'D) r -> ('f, 'b, 'D) r -> ('f, 'a * 'b, 'D) r

  (* *)

  val ( >>= ) : ('f, 'a, 'D) r -> ('a -> ('f, 'b, 'D) r) -> ('f, 'b, 'D) r
  val ( >> ) : ('f, unit, 'D) r -> ('f, 'a, 'D) r -> ('f, 'a, 'D) r

  val ( >=> ) :
    ('a -> ('f, 'b, 'D) r) -> ('b -> ('f, 'c, 'D) r) -> 'a -> ('f, 'c, 'D) r

  (* *)

  val ( ||| ) : ('f, bool, 'D) r bop
  val ( &&& ) : ('f, bool, 'D) r bop

  (* *)

  val delay : (unit -> ('f, 'a, 'D) r) -> ('f, 'a, 'D) r
end
