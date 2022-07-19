open Misc.Syntax
include module type of Stdlib.List

val for_alli : (int -> 'a -> bool) -> 'a list -> bool
val equal_with : 'a bpr -> 'a list bpr
val compare_with : 'a cmp -> 'a list cmp
val find_dup_opt : 'a cmp -> 'a list -> ('a * 'a) option

(* *)

val map_phys_eq : 'a uop -> 'a list uop
val share_phys_eq : 'a bop -> 'a list bop

(* *)

val fold_left3 :
  ('a -> 'b -> 'c -> 'd -> 'a) -> 'a -> 'b list -> 'c list -> 'd list -> 'a

(* *)

val fold_left_fr :
  ('a -> 'b -> ('f, 'a, 'D) Monad.r) -> 'a -> 'b t -> ('f, 'a, 'D) Monad.r

val fold_left2_fr :
  ('a -> 'b -> 'c -> ('f, 'a, 'D) Monad.r) ->
  'a ->
  'b t ->
  'c t ->
  ('f, 'a, 'D) Monad.r

val fold_left3_fr :
  ('a -> 'b -> 'c -> 'd -> ('f, 'a, 'D) Monad.r) ->
  'a ->
  'b t ->
  'c t ->
  'd t ->
  ('f, 'a, 'D) Monad.r

(* *)

val iter_fr : ('a -> ('f, unit, 'D) Monad.r) -> 'a t -> ('f, unit, 'D) Monad.r

val iter2_fr :
  ('a -> 'b -> ('f, unit, 'D) Monad.r) -> 'a t -> 'b t -> ('f, unit, 'D) Monad.r

val iter3_fr :
  ('a -> 'b -> 'c -> ('f, unit, 'D) Monad.r) ->
  'a t ->
  'b t ->
  'c t ->
  ('f, unit, 'D) Monad.r

(* *)

val for_all_fr :
  ('a -> ('f, bool, 'D) Monad.r) -> 'a t -> ('f, bool, 'D) Monad.r

val exists_fr : ('a -> ('f, bool, 'D) Monad.r) -> 'a t -> ('f, bool, 'D) Monad.r

(* *)

val find_opt_fr :
  ('a -> ('f, bool, 'D) Monad.r) -> 'a t -> ('f, 'a option, 'D) Monad.r

val find_map_fr :
  ('a -> ('f, 'b option, 'D) Monad.r) -> 'a t -> ('f, 'b option, 'D) Monad.r

(* *)

val map_m : ('a -> ('f, 'b, 'D) Monad.r) -> 'a t -> ('f, 'b t, 'D) Monad.r

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.r) -> 'a t -> ('f, 'b t, 'D) Applicative.r

val map2_fr :
  ('a -> 'b -> ('f, 'c, 'D) Applicative.r) ->
  'a t ->
  'b t ->
  ('f, 'c t, 'D) Applicative.r

val map_phys_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.r) -> 'a t -> ('f, 'a t, 'D) Applicative.r

(* *)

val filter_fr :
  ('a -> ('f, bool, 'D) Applicative.r) -> 'a t -> ('f, 'a t, 'D) Applicative.r
