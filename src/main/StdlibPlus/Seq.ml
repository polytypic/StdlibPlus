open Rea
include Stdlib.Seq
include StdRea.Seq

let rec exists_er (p : 'a -> _) =
  eta'1 @@ fun (xs : 'a t) ->
  match uncons xs with
  | Some (x, xs) -> p x ||| exists_er p xs
  | None -> pure false

let rec find_opt_er p =
  eta'1 @@ fun xs ->
  match uncons xs with
  | Some (x, xs) ->
    p x >>= fun b -> if b then pure @@ Some x else find_opt_er p xs
  | None -> pure None
