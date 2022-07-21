open Functor.Syntax
open Applicative.Syntax
include Stdlib.Option

let map_fr xyF = function
  | None -> return None
  | Some x -> xyF x >>- fun y -> Some y

let map_eq_fr xxF = function
  | None -> return None
  | Some x as some -> xxF x >>- fun x' -> if x == x' then some else Some x'

let iter_fr xuF = function None -> unit | Some x -> xuF x

(* *)

let exists pr = function None -> false | Some x -> pr x
let or_else r = function None -> r () | some -> some
let both f l r = match (l, r) with Some l, Some r -> Some (f l r) | _ -> None

(* *)

include Higher.New'1 (Stdlib.Option) ()

type 'a fr = < f Monad.t ; f Alternative.t > -> 'a f'1

let methods =
  object
    inherit [_] Monad.t
    method return x = inj (Some x)
    method bind xyF xF = inj (bind (prj xF) (fun x -> prj (xyF x)))
    inherit [_] Alternative.t
    method zero = inj None
    method alt lA rA = if is_none (prj lA) then rA else lA
  end

let run xF = xF methods |> prj
