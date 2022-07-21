open Higher.Syntax

class virtual ['f] t =
  object
    method virtual map : 'a 'b. ('f, 'a, 'b) Method.map
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let ( let+ ) xM xy : (_, _, _) r = fun f -> xM f |> f#map xy

  (* *)

  let ( >>- ) = ( let+ )
  let ( >-> ) abM bc a = abM a >>- bc

  (* *)

  let lift1 xy xF = xF >>- xy
end
