open Concepts.Syntax

let as_cases c = if c < 0 then `Lt else if 0 < c then `Gt else `Eq

module Syntax = struct
  let ( <>? ) lhs rhs = if lhs = 0 then rhs () else lhs
  let ( <?> ) c1 c2 l r = c1 l r <>? fun () -> c2 l r
end

open Syntax

let the part_of compare lhs rhs = compare (part_of lhs) (part_of rhs)

module Tuple'2 (T1 : OrderedType) (T2 : OrderedType) = struct
  type t = T1.t * T2.t

  let compare (l1, l2) (r1, r2) =
    T1.compare l1 r1 <>? fun () -> T2.compare l2 r2
end

module Tuple'3 (T1 : OrderedType) (T2 : OrderedType) (T3 : OrderedType) = struct
  type t = T1.t * T2.t * T3.t

  let compare (l1, l2, l3) (r1, r2, r3) =
    T1.compare l1 r1 <>? fun () ->
    T2.compare l2 r2 <>? fun () -> T3.compare l3 r3
end

module Tuple'4
    (T1 : OrderedType)
    (T2 : OrderedType)
    (T3 : OrderedType)
    (T4 : OrderedType) =
struct
  type t = T1.t * T2.t * T3.t * T4.t

  let compare (l1, l2, l3, l4) (r1, r2, r3, r4) =
    T1.compare l1 r1 <>? fun () ->
    T2.compare l2 r2 <>? fun () ->
    T3.compare l3 r3 <>? fun () -> T4.compare l4 r4
end
