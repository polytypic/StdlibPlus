open Higher.Syntax

type ('f, 'a, 'b) map = ('a -> 'b) -> ('f, 'a) app'1 -> ('f, 'b) app'1
type 'f t = < map : 'a 'b. ('f, 'a, 'b) map >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let ( let+ ) xM xy : (_, _, _) r = fun f -> xM f |> f#map xy

  (* *)

  let ( >>- ) = ( let+ )
  let ( >-> ) abM bc a = abM a >>- bc

  (* *)

  let lift1 xy xF = xF >>- xy
end
