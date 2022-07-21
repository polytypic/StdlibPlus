open Fun.Syntax
open Higher.Syntax
open Functor.Syntax

class virtual ['f] t =
  object
    inherit ['f] Applicative.t
    method virtual branch : 'a 'b 'c. ('f, 'a, 'b, 'c) Method.branch
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax = struct
  let branch xyS xzS yzS : (_, _, _) r =
   fun f -> f#branch (xyS f) (xzS f) (yzS f)

  let if_else_s bS tS eS =
    branch
      (bS >>- function true -> Either.Left () | false -> Either.Right ())
      (tS >>- const) (eS >>- const)
end
