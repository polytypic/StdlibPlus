open Misc.Syntax

val set_fst : 'a * 'b -> 'c -> 'c * 'b
val set_snd : 'a * 'b -> 'c -> 'a * 'c

val swap : 'a * 'b -> 'b * 'a
(** Swap elements of a pair. *)

val map : ('a -> 'b) -> ('c -> 'd) -> 'a * 'c -> 'b * 'd
val map_phys_eq : 'a uop -> 'b uop -> ('a * 'b) uop
val share_phys_eq : 'a bop -> 'b bop -> ('a * 'b) bop

(* *)

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.r) ->
  ('c -> ('f, 'd, 'D) Applicative.r) ->
  'a * 'c ->
  ('f, 'b * 'd, 'D) Applicative.r

val map_phys_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.r) ->
  ('b -> ('f, 'b, 'D) Applicative.r) ->
  'a * 'b ->
  ('f, 'a * 'b, 'D) Applicative.r
