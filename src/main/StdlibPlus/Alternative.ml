open Higher.Syntax

type ('f, 'a) zero = ('f, 'a) app'1
type ('f, 'a) alt = ('f, 'a) app'1 -> ('f, 'a) app'1 -> ('f, 'a) app'1
type 'f t = < zero : 'a. ('f, 'a) zero ; alt : 'a. ('f, 'a) alt >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let zero : (_, _, _) r = fun f -> f#zero
  let ( <|> ) lA rA : (_, _, _) r = fun f -> f#alt (lA f) (rA f)
end
