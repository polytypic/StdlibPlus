open Method

val map_of :
  < return : 'a. ('f, 'a) return ; bind : 'a 'b. ('f, 'a, 'b) bind ; .. > ->
  ('f, 'a, 'b) map

val pair_of :
  < map : 'a 'b. ('f, 'a, 'b) map ; bind : 'a 'b. ('f, 'a, 'b) bind ; .. > ->
  ('f, 'a, 'b) pair
