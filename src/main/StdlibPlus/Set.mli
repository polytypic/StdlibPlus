module type OrderedType = Stdlib.Set.OrderedType

module type S = sig
  include Stdlib.Set.S

  val filter_fr : (elt -> ('f, bool, 'D) Monad.r) -> t -> ('f, t, 'D) Monad.r
end

module Make : functor (Ord : OrderedType) -> S with type elt = Ord.t
