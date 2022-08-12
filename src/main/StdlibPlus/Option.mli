open Rea
include module type of Stdlib.Option
include module type of StdRea.Option

val iter_er :
  ('a -> ('R, 'e, unit, (('R, 'D) #applicative' as 'D)) er) ->
  'a t ->
  ('R, 'e, unit, 'D) er

(* *)

val exists : ('a -> bool) -> 'a t -> bool
val or_else : (unit -> 'a t) -> 'a t -> 'a t
val both : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t
