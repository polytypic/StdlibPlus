open Higher.Syntax

type ('f, 'a) zero = ('f, 'a) app'1
type ('f, 'a) alt = ('f, 'a) app'1 -> ('f, 'a) app'1 -> ('f, 'a) app'1
type 'f t = < zero : 'a. ('f, 'a) zero ; alt : 'a. ('f, 'a) alt >
type ('f, 'F, 'a) fr = (< 'f t ; .. > as 'F) -> ('f, 'a) app'1

module Syntax : sig
  val zero : ('f, 'F, 'a) fr
  val ( <|> ) : ('f, 'F, 'a) fr -> ('f, 'F, 'a) fr -> ('f, 'F, 'a) fr
end
