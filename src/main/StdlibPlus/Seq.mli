include module type of Stdlib.Seq

val exists_fr : ('a -> ('f, bool, 'D) Monad.r) -> 'a t -> ('f, bool, 'D) Monad.r
