type 'a t = 'a * 'a

val exists : ('a -> bool) -> 'a t -> bool

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.r) -> 'a t -> ('f, 'b t, 'D) Applicative.r

val map_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.r) -> 'a t -> ('f, 'a t, 'D) Applicative.r
