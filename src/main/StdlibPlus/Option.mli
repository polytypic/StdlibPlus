open Higher.Syntax
include module type of Stdlib.Option

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.fr) -> 'a t -> ('f, 'b t, 'D) Applicative.fr

val map_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.fr) -> 'a t -> ('f, 'a t, 'D) Applicative.fr

val iter_fr :
  ('a -> ('f, unit, 'D) Applicative.fr) -> 'a t -> ('f, unit, 'D) Applicative.fr

(* *)

val exists : ('a -> bool) -> 'a t -> bool
val or_else : (unit -> 'a t) -> 'a t -> 'a t
val both : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t

(* *)

include Higher.F'1 with type 'a t'1 = 'a t

type 'a fr = < f Monad.t ; f Alternative.t > -> (f, 'a) app'1

val run : 'a fr -> 'a t
