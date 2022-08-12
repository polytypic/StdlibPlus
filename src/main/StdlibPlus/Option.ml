open Rea
include Stdlib.Option
include StdRea.Option

let iter_er xuE = function None -> unit | Some x -> eta'1 xuE x

(* *)

let exists pr = function None -> false | Some x -> pr x
let or_else r = function None -> r () | some -> some
let both f l r = match (l, r) with Some l, Some r -> Some (f l r) | _ -> None
