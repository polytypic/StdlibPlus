open Higher.Syntax

type ('f, 'a, 'b) map = ('a -> 'b) -> ('f, 'a) app'1 -> ('f, 'b) app'1
type 'f t = < map : 'a 'b. ('f, 'a, 'b) map >
type ('f, 'a, 'D) fr = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'a, 'f t) fr

module Syntax : sig
  val ( let+ ) : ('f, 'a, 'D) fr -> ('a -> 'b) -> ('f, 'b, 'D) fr

  (* *)

  val ( >>- ) : ('f, 'a, 'D) fr -> ('a -> 'b) -> ('f, 'b, 'D) fr
  val ( >-> ) : ('a -> ('f, 'b, 'D) fr) -> ('b -> 'c) -> 'a -> ('f, 'c, 'D) fr

  (* *)

  val lift1 : ('a -> 'b) -> ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr
end
