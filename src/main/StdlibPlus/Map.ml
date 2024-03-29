open Rea
open Fun.Syntax

module type OrderedType = Stdlib.Map.OrderedType

module type S = sig
  include Stdlib.Map.S

  val add_list : (key * 'v) list -> 'v t -> 'v t
  val of_list : (key * 'v) list -> 'v t

  val exists_er :
    (key -> 'v -> ('R, 'e, bool, (('R, 'D) #monad' as 'D)) er) ->
    'v t ->
    ('R, 'e, bool, 'D) er
end

module Make (Ord : OrderedType) = struct
  include Stdlib.Map.Make (Ord)

  let add_list kvs = List.to_seq kvs |> add_seq
  let of_list kvs = List.to_seq kvs |> of_seq
  let exists_er fn = to_seq >>> Seq.exists_er (uncurry fn)
end

let prefer_lhs _ l r =
  match (l, r) with
  | (Some _ as some), _ | _, (Some _ as some) -> some
  | _, _ -> None

let prefer_rhs _ l r =
  match (l, r) with
  | _, (Some _ as some) | (Some _ as some), _ -> some
  | _, _ -> None

let combining_with plus _ l r =
  match (l, r) with
  | Some l, Some r -> Some (plus l r)
  | None, (Some _ as some) | (Some _ as some), None -> some
  | None, None -> None
