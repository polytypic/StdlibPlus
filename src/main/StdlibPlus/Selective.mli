open Misc.Syntax
open Higher.Syntax

class virtual ['f] t :
  object
    inherit ['f] Applicative.t
    method virtual branch : 'a 'b 'c. ('f, 'a, 'b, 'c) Method.branch
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val branch :
    ('f, ('a, 'b) Either.t, 'D) r ->
    ('f, 'a -> 'c, 'D) r ->
    ('f, 'b -> 'c, 'D) r ->
    ('f, 'c, 'D) r

  val if_else_s : ('f, bool, 'D) r -> ('f, 'a, 'D) r bop
end
