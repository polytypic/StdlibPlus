open Higher.Syntax

type ('f, 'a) zero = ('f, 'a) app'1
type ('f, 'a) alt = ('f, 'a) app'1 -> ('f, 'a) app'1 -> ('f, 'a) app'1
type 'f t = < zero : 'a. ('f, 'a) zero ; alt : 'a. ('f, 'a) alt >
type ('f, 'a, 'D) fr = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val zero : ('f, 'a, 'D) fr
  val ( <|> ) : ('f, 'a, 'D) fr -> ('f, 'a, 'D) fr -> ('f, 'a, 'D) fr
end
