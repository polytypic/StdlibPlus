open Rea
open Concepts.Syntax
include module type of Stdlib.List
include module type of StdRea.List

val for_alli : (int -> 'a -> bool) -> 'a list -> bool
val equal_with : 'a bpr -> 'a list bpr
val compare_with : 'a cmp -> 'a list cmp
val find_dup_opt : 'a cmp -> 'a list -> ('a * 'a) option

(* *)

val map_eq : 'a uop -> 'a list uop
val share_eq : 'a bop -> 'a list bop

(* *)

val fold_left'3 :
  ('a -> 'b -> 'c -> 'd -> 'a) -> 'a -> 'b list -> 'c list -> 'd list -> 'a

(* *)

val fold_left_er :
  ('a -> 'b -> ('R, 'e, 'a, (('R, 'D) #monad' as 'D)) er) ->
  'a ->
  'b t ->
  ('R, 'e, 'a, 'D) er

val fold_left_er'2 :
  ('a -> 'b -> 'c -> ('R, 'e, 'a, (('R, 'D) #monad' as 'D)) er) ->
  'a ->
  'b t ->
  'c t ->
  ('R, 'e, 'a, 'D) er

val fold_left_er'3 :
  ('a -> 'b -> 'c -> 'd -> ('R, 'e, 'a, (('R, 'D) #monad' as 'D)) er) ->
  'a ->
  'b t ->
  'c t ->
  'd t ->
  ('R, 'e, 'a, 'D) er

(* *)

val iter_er :
  ('a -> ('R, 'e, unit, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, unit, 'D) er

val iter_er'2 :
  ('a -> 'b -> ('R, 'e, unit, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  'b t ->
  ('R, 'e, unit, 'D) er

val iter_er'3 :
  ('a -> 'b -> 'c -> ('R, 'e, unit, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  'b t ->
  'c t ->
  ('R, 'e, unit, 'D) er

(* *)

val for_all_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, bool, 'D) er

val exists_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, bool, 'D) er

(* *)

val find_opt_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'a option, 'D) er

val find_map_er :
  ('a -> ('R, 'e, 'b option, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'b option, 'D) er

(* *)

val map_er'2 :
  ('a -> 'b -> ('R, 'e, 'c, (('R, 'D) #applicative' as 'D)) er) ->
  'a t ->
  'b t ->
  ('R, 'e, 'c t, 'D) er

(* *)

val filter_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #applicative' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'a t, 'D) er
