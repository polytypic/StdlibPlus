open Rea
open Concepts.Syntax

val set_fst : 'a * 'b -> 'c -> 'c * 'b
val set_snd : 'a * 'b -> 'c -> 'a * 'c

val swap : 'a * 'b -> 'b * 'a
(** Swap elements of a pair. *)

val map : ('a -> 'b) -> ('c -> 'd) -> 'a * 'c -> 'b * 'd
val map_eq : 'a uop -> 'b uop -> ('a * 'b) uop
val share_eq : 'a bop -> 'b bop -> ('a * 'b) bop

(* *)

val map_er :
  ('a -> ('R, 'e, 'b, (('R, 'D) #applicative' as 'D)) er) ->
  ('c -> ('R, 'e, 'd, 'D) er) ->
  'a * 'c ->
  ('R, 'e, 'b * 'd, 'D) er

val map_eq_er :
  ('a -> ('R, 'e, 'a, (('R, 'D) #applicative' as 'D)) er) ->
  ('b -> ('R, 'e, 'b, 'D) er) ->
  'a * 'b ->
  ('R, 'e, 'a * 'b, 'D) er
