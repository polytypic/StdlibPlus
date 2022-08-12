open Rea

let set_fst (_, y) x = (x, y)
let set_snd (x, _) y = (x, y)
let swap (x, y) = (y, x)
let map f g (x, y) = (f x, g y)

let map_eq f g ((x, y) as inn) =
  let x' = f x in
  let y' = g y in
  if x == x' && y == y' then inn else (x', y')

let share_eq share_l share_r ((o_l, o_r) as o) (l, r) =
  let l = share_l o_l l in
  let r = share_r o_r r in
  if o_l == l && o_r == r then o else (l, r)

let map_er = map_er'2
let map_eq_er = map_eq_er'2
