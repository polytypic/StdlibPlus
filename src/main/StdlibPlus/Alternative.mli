open Higher.Syntax

type 'f t = < zero : 'a. ('f, 'a) Method.zero ; alt : 'a. ('f, 'a) Method.alt >
type ('f, 'a, 'D) r = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val zero : ('f, 'a, 'D) r
  val ( <|> ) : ('f, 'a, 'D) r -> ('f, 'a, 'D) r -> ('f, 'a, 'D) r
end
