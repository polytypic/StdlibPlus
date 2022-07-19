open Fun.Syntax
open Functor.Syntax

module type OrderedType = Stdlib.Set.OrderedType

module type S = sig
  include Stdlib.Set.S

  val filter_fr : (elt -> ('f, bool, 'D) Monad.r) -> t -> ('f, t, 'D) Monad.r
end

module Make (Ord : OrderedType) = struct
  include Stdlib.Set.Make (Ord)

  let filter_fr pr = elements >>> List.filter_fr pr >-> of_list
end
