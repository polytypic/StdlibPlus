open Compare.Syntax

type t = Pos.t * Pos.t

let of_path path =
  let pos = Pos.of_path path in
  (pos, Pos.add_cnum 1 pos)

let dummy = (Lexing.dummy_pos, Lexing.dummy_pos)
let union l r = (fst l, snd r)
let path ((l : Pos.t), _) = l.pos_fname

let compare (ll, lr) (rl, rr) =
  Pos.compare ll rl <>? fun () -> Pos.compare lr rr

let equal l r = compare l r = 0
let is_dummy = equal dummy
let is_empty (l, r) = Pos.equal l r
