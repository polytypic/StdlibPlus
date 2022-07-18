open Higher.Syntax
open Misc.Syntax

type ('f, 'a, 'b) bind =
  ('a -> ('f, 'b) app'1) -> ('f, 'a) app'1 -> ('f, 'b) app'1

type 'f t = < 'f Applicative.t ; bind : 'a 'b. ('f, 'a, 'b) bind >
type ('f, 'F, 'a) fr = (< 'f t ; .. > as 'F) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'f t, 'a) fr

module Syntax : sig
  val ( let* ) : ('f, 'F, 'a) fr -> ('a -> ('f, 'F, 'b) fr) -> ('f, 'F, 'b) fr
  val ( and* ) : ('f, 'F, 'a) fr -> ('f, 'F, 'b) fr -> ('f, 'F, 'a * 'b) fr

  (* *)

  val ( >>= ) : ('f, 'F, 'a) fr -> ('a -> ('f, 'F, 'b) fr) -> ('f, 'F, 'b) fr
  val ( >> ) : ('f, 'F, unit) fr -> ('f, 'F, 'a) fr -> ('f, 'F, 'a) fr

  val ( >=> ) :
    ('a -> ('f, 'F, 'b) fr) -> ('b -> ('f, 'F, 'c) fr) -> 'a -> ('f, 'F, 'c) fr

  (* *)

  val ( ||| ) : ('f, 'F, bool) fr bop
  val ( &&& ) : ('f, 'F, bool) fr bop

  (* *)

  val delay : (unit -> ('f, 'F, 'a) fr) -> ('f, 'F, 'a) fr
end
