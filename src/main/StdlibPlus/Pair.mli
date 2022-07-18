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
  ('a -> ('f, 'b, 'D) Applicative.fr) ->
  ('c -> ('f, 'd, 'D) Applicative.fr) ->
  'a * 'c ->
  ('f, 'b * 'd, 'D) Applicative.fr

val map_phys_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.fr) ->
  ('b -> ('f, 'b, 'D) Applicative.fr) ->
  'a * 'b ->
  ('f, 'a * 'b, 'D) Applicative.fr
