open Rea
include module type of Stdlib.Seq
include module type of StdRea.Seq

val exists_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, bool, 'D) er

val find_opt_er :
  ('a -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
  'a t ->
  ('R, 'e, 'a option, 'D) er
