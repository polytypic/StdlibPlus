type 'a t = 'a * 'a

val exists : ('a -> bool) -> 'a t -> bool

val map_fr :
  ('a -> ('f, 'b, 'D) Applicative.fr) -> 'a t -> ('f, 'b t, 'D) Applicative.fr

val map_eq_fr :
  ('a -> ('f, 'a, 'D) Applicative.fr) -> 'a t -> ('f, 'a t, 'D) Applicative.fr
