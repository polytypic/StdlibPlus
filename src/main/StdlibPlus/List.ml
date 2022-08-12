open Rea
open Compare.Syntax

(* *)

include Stdlib.List
include StdRea.List

let rec map xy ys = function x :: xs -> map xy (xy x :: ys) xs | [] -> rev ys
let map xy = map xy []

let rec for_alli p i = function
  | x :: xs -> p i x && for_alli p (i + 1) xs
  | [] -> true

let for_alli p = for_alli p 0

let equal_with equal xs ys =
  try for_all2 equal xs ys with Invalid_argument _ -> false

let rec compare_with compare xs ys =
  match (xs, ys) with
  | [], [] -> 0
  | [], _ -> -1
  | _, [] -> 1
  | x :: xs, y :: ys -> compare x y <>? fun () -> compare_with compare xs ys

let rec map_eq fn inn =
  match inn with
  | [] -> inn
  | x :: xs as inn ->
    let x' = fn x in
    let xs' = map_eq fn xs in
    if x == x' && xs == xs' then inn else x' :: xs'

let rec share_eq share_eq_elem original changed =
  match (original, changed) with
  | [], [] -> original
  | o :: os, c :: cs ->
    let cs = share_eq share_eq_elem os cs in
    let c = share_eq_elem o c in
    if os == cs && o == c then original else c :: cs
  | _ -> raise @@ Invalid_argument "List.share_eq"

let find_dup_opt cmp xs =
  let rec loop = function
    | x1 :: (x2 :: _ as xs) -> if 0 = cmp x1 x2 then Some (x1, x2) else loop xs
    | _ -> None
  in
  xs |> Stdlib.List.stable_sort cmp |> loop

(* *)

let rec fold_left'3 xyzwx x ys zs ws =
  match (ys, zs, ws) with
  | y :: ys, z :: zs, w :: ws -> fold_left'3 xyzwx (xyzwx x y z w) ys zs ws
  | [], [], [] -> x
  | _ -> raise @@ Invalid_argument "fold_left'3"

(* *)

let rec fold_left_er xyx x = function
  | [] -> pure x
  | y :: ys -> xyx x y >>= fun x -> fold_left_er xyx x ys

let rec fold_left_er'2 xyzx x ys zs =
  match (ys, zs) with
  | y :: ys, z :: zs -> xyzx x y z >>= fun x -> fold_left_er'2 xyzx x ys zs
  | [], [] -> pure x
  | _ -> raise @@ Invalid_argument "fold_left_er'2"

let rec fold_left_er'3 xyzwx x ys zs ws =
  match (ys, zs, ws) with
  | y :: ys, z :: zs, w :: ws ->
    xyzwx x y z w >>= fun x -> fold_left_er'3 xyzwx x ys zs ws
  | [], [], [] -> pure x
  | _ -> raise @@ Invalid_argument "fold_left_er'3"

(* *)

let rec iter_er xy = function
  | x :: xs -> xy x >>= fun () -> iter_er xy xs
  | [] -> unit

let rec iter_er'2 xyuF xs ys =
  match (xs, ys) with
  | x :: xs, y :: ys -> xyuF x y >>= fun () -> iter_er'2 xyuF xs ys
  | [], [] -> unit
  | _ -> raise @@ Invalid_argument "iter_er'2"

let rec iter_er'3 xywuF xs ys ws =
  match (xs, ys, ws) with
  | x :: xs, y :: ys, w :: ws ->
    xywuF x y w >>= fun () -> iter_er'3 xywuF xs ys ws
  | [], [], [] -> unit
  | _ -> raise @@ Invalid_argument "iter_er'3"

(* *)

let rec for_all_er p =
  eta'1 @@ function x :: xs -> p x &&& for_all_er p xs | [] -> pure true

let rec exists_er p =
  eta'1 @@ function x :: xs -> p x ||| exists_er p xs | [] -> pure false

(* *)

let rec find_opt_er p =
  eta'1 @@ function
  | x :: xs -> p x >>= fun b -> if b then pure @@ Some x else find_opt_er p xs
  | [] -> pure None

(* *)

let rec map_er'2 xyzF zsF xs ys =
  match (xs, ys) with
  | x :: xs, y :: ys ->
    map_er'2 xyzF (xyzF x y <*> zsF >>- fun (z, zs) -> z :: zs) xs ys
  | [], [] -> zsF >>- rev
  | _ -> raise @@ Invalid_argument "map_er'2"

let map_er'2 xyzF = map_er'2 xyzF (pure [])

(* *)

let rec filter_er fn = function
  | [] -> pure []
  | x :: xs -> (
    fn x <*> filter_er fn xs >>- function b, xs -> if b then x :: xs else xs)

(* *)

let rec find_map_er fn =
  eta'1 @@ function
  | [] -> pure None
  | x :: xs -> (
    fn x >>= function None -> find_map_er fn xs | some -> pure some)
