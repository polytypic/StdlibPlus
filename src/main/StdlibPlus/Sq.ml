open Rea

type 'a t = 'a * 'a

let exists pr (x, y) = pr x || pr y
let map_er f = map_er'2 f f
let map_eq_er f = map_eq_er'2 f f
