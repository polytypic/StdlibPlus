open Misc.Syntax

val to_map :
  (('a -> 'b Identity.mr) -> 's -> 't Identity.mr) -> ('a -> 'b) -> 's -> 't

val to_set : (('a -> 'b Identity.mr) -> 's -> 't Identity.mr) -> 'b -> 's -> 't

val to_map_constant :
  (('a -> ('M -> ('c, 'I) Constant.f'2 as 'R)) -> 's -> 'R) ->
  'M ->
  ('a -> 'c) ->
  's ->
  'c

val to_get : (('a -> (('a, 'I) Constant.fr as 'R)) -> 's -> 'R) -> 's -> 'a

val to_get_opt :
  (('a -> (('a option, 'I) Constant.ar as 'R)) -> 's -> 'R) -> 's -> 'a option

val to_exists :
  (('a -> ((bool Lazy.t, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  ('a -> bool) ->
  's ->
  bool

val to_exists_fr :
  (('a -> (('a Cat.t, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  ('a -> ('f, bool, 'D) Monad.r) ->
  's ->
  ('f, bool, 'D) Monad.r

val to_iter_fr :
  (('a -> ((('f, unit, 'D) Monad.r, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  ('a -> ('f, unit, 'D) Monad.r) ->
  's ->
  ('f, unit, 'D) Monad.r

val to_find_map :
  (('a -> (('b option Lazy.t, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  ('a -> 'b option) ->
  's ->
  'b option

val to_find_map_fr :
  (('a -> (('a Cat.t, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  ('a -> ('f, 'b option, 'D) Monad.r) ->
  's ->
  ('f, 'b option, 'D) Monad.r

val to_collect :
  (('a -> (('a Cat.t, 'I) Constant.ar as 'R)) -> 's -> 'R) -> 's -> 'a list

val to_map_reduce :
  (('a -> (('m, 'I) Constant.ar as 'R)) -> 's -> 'R) ->
  'm bop ->
  'm ->
  ('a -> 'm) ->
  's ->
  'm
