open Rea
open Concepts.Syntax

module type OrderedType = OrderedType

module type S = sig
  include Stdlib.Map.S

  val add_list : (key * 'v) list -> 'v t uop
  val of_list : (key * 'v) list -> 'v t

  val exists_er :
    (key -> 'v -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
    'v t ->
    ('R, 'e, bool, 'D) er
end

module Make : functor (Ord : OrderedType) -> S with type key = Ord.t

val prefer_lhs : 'k -> 'v option bop
val prefer_rhs : 'k -> 'v option bop
val combining_with : 'v bop -> 'k -> 'v option bop
