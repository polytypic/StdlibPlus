open Higher.Syntax
open Misc.Syntax

type 'f t = < 'f Applicative.t ; bind : 'a 'b. ('f, 'a, 'b) Method.bind >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

class virtual ['f] of_bind :
  object
    method virtual return : 'a. ('f, 'a) Method.return
    method virtual bind : 'a 'b. ('f, 'a, 'b) Method.bind
    method map : 'a 'b. ('f, 'a, 'b) Method.map
    method pair : 'a 'b. ('f, 'a, 'b) Method.pair
  end

val of_bind :
  < return : 'a. ('f, 'a) Method.return
  ; bind : 'a 'b. ('f, 'a, 'b) Method.bind > ->
  'f t

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
