open Higher.Syntax

type 'f t = < zero : 'a. ('f, 'a) Method.zero ; alt : 'a. ('f, 'a) Method.alt >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let zero : (_, _, _) r = fun f -> f#zero
  let ( <|> ) lA rA : (_, _, _) r = fun f -> f#alt (lA f) (rA f)
end
