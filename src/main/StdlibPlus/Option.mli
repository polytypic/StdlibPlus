include module type of Stdlib.Option

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.r) -> 'a t -> ('f, 'b t, 'D) Applicative.r

val map_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.r) -> 'a t -> ('f, 'a t, 'D) Applicative.r

val iter_fr :
  ('a -> ('f, unit, 'D) Applicative.r) -> 'a t -> ('f, unit, 'D) Applicative.r

(* *)

val exists : ('a -> bool) -> 'a t -> bool
val or_else : (unit -> 'a t) -> 'a t -> 'a t
val both : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t

(* *)

include Higher.F'1 with type 'a t'1 = 'a t

type 'a fr = < f Monad.t ; f Alternative.t > -> 'a f'1

val run : 'a fr -> 'a t
