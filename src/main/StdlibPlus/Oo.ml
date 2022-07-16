include Stdlib.Oo

module Prop = struct
  type 'a t = 'a option -> 'a

  let get f r = f r None

  let set f x r =
    let r = copy r in
    f r @@ Some x |> ignore;
    r

  let map f fn r =
    let r = copy r in
    f r @@ Some (fn (f r None)) |> ignore;
    r
end

module Syntax = struct
  let prop get set = function
    | None -> get ()
    | Some x ->
      set x;
      x
end
