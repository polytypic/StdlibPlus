open Rea

type 'a t = 'a * 'a

val exists : ('a -> bool) -> 'a t -> bool

val map_er :
  ('a -> ('R, 'e, 'b, (('R, 'D) #applicative' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'b t, 'D) er

val map_eq_er :
  ('a -> ('R, 'e, 'a, (('R, 'D) #applicative' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'a t, 'D) er
