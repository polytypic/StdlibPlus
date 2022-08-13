open Rea

module Syntax : sig
  type 'a uop = 'a -> 'a
  type 'a bop = 'a -> 'a -> 'a
  type 'a bpr = 'a -> 'a -> bool
  type 'a cmp = 'a -> 'a -> int

  (* *)

  val eq'2 : ('a * 'b) bpr
  val eq'3 : ('a * 'b * 'c) bpr
  val eq'4 : ('a * 'b * 'c * 'd) bpr

  (* *)

  val pure'0 : (unit -> 'a) -> ('R, 'e, 'a, (('R, 'D) #pure' as 'D)) er
  val pure'1 : ('b1 -> 'a) -> 'b1 -> ('R, 'e, 'a, (('R, 'D) #pure' as 'D)) er

  val pure'2 :
    ('b1 -> 'b2 -> 'a) -> 'b1 -> 'b2 -> ('R, 'e, 'a, (('R, 'D) #pure' as 'D)) er

  val pure'3 :
    ('b1 -> 'b2 -> 'b3 -> 'a) ->
    'b1 ->
    'b2 ->
    'b3 ->
    ('R, 'e, 'a, (('R, 'D) #pure' as 'D)) er

  (* *)

  module type OrderedType = Stdlib.Set.OrderedType
end
