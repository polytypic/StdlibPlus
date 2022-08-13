open Rea

module Syntax = struct
  type 'a uop = 'a -> 'a
  type 'a bop = 'a -> 'a -> 'a
  type 'a bpr = 'a -> 'a -> bool
  type 'a cmp = 'a -> 'a -> int

  (* *)

  let eq'2 (a, b) (s, t) = a == s && b == t
  let eq'3 (a, b, c) (s, t, u) = a == s && b == t && c == u
  let eq'4 (a, b, c, d) (s, t, u, v) = a == s && b == t && c == u && d == v

  (* *)

  let pure'0 ux (d : (_, _) #pure') = d#pure' (ux ())
  let pure'1 x1y x1 (d : (_, _) #pure') = d#pure' (x1y x1)
  let pure'2 x1x2y x1 x2 (d : (_, _) #pure') = d#pure' (x1x2y x1 x2)
  let pure'3 x1x2x3y x1 x2 x3 (d : (_, _) #pure') = d#pure' (x1x2x3y x1 x2 x3)

  (* *)

  module type OrderedType = Stdlib.Set.OrderedType
end
