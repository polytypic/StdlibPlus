open Rea

module type OrderedType = Stdlib.Set.OrderedType

module type S = sig
  include Stdlib.Set.S

  val filter_er :
    (elt -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
    t ->
    ('R, 'e, t, 'D) er
end

module Make : functor (Ord : OrderedType) -> S with type elt = Ord.t
