type 'a t = 'a

include Higher.F'1 with type 'a t'1 = 'a

type 'a mr = f Monad.t -> 'a f'1

val run : 'a mr -> 'a
