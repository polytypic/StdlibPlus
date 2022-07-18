include module type of Stdlib.Seq

val exists_fr :
  ('a -> ('f, bool, 'D) Monad.fr) -> 'a t -> ('f, bool, 'D) Monad.fr
