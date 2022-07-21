open Higher.Syntax

class virtual ['f] t :
  object
    method virtual zero : 'a. ('f, 'a) Method.zero
    method virtual alt : 'a. ('f, 'a) Method.alt
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val zero : ('f, 'a, 'D) r
  val ( <|> ) : ('f, 'a, 'D) r -> ('f, 'a, 'D) r -> ('f, 'a, 'D) r
end
