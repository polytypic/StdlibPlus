open Higher.Syntax

class virtual ['f] t :
  object
    method virtual map : 'a 'b. ('f, 'a, 'b) Method.map
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val ( let+ ) : ('f, 'a, 'D) r -> ('a -> 'b) -> ('f, 'b, 'D) r

  (* *)

  val ( >>- ) : ('f, 'a, 'D) r -> ('a -> 'b) -> ('f, 'b, 'D) r
  val ( >-> ) : ('a -> ('f, 'b, 'D) r) -> ('b -> 'c) -> 'a -> ('f, 'c, 'D) r

  (* *)

  val lift1 : ('a -> 'b) -> ('f, 'a, 'D) r -> ('f, 'b, 'D) r
end
