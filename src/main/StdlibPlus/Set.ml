open Rea
open Fun.Syntax

module type OrderedType = Stdlib.Set.OrderedType

module type S = sig
  include Stdlib.Set.S

  val filter_er :
    (elt -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
    t ->
    ('R, 'e, t, 'D) er
end

module Make (Ord : OrderedType) = struct
  include Stdlib.Set.Make (Ord)

  let filter_er pr = elements >>> List.filter_er pr >-> of_list
end
