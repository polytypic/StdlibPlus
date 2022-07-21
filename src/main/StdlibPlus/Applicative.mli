open Higher.Syntax

class virtual ['f] t :
  object
    inherit ['f] Functor.t
    method virtual return : 'a. ('f, 'a) Method.return
    method virtual pair : 'a 'b. ('f, 'a, 'b) Method.pair
  end

type ('f, 'a, 'D) r = ('f #t as 'D) -> ('f, 'a) app'1

module Syntax : sig
  val return : 'a -> ('f, 'a, 'D) r
  val ( and+ ) : ('f, 'a, 'D) r -> ('f, 'b, 'D) r -> ('f, 'a * 'b, 'D) r

  (* *)

  val ( <*> ) : ('f, 'a, 'D) r -> ('f, 'b, 'D) r -> ('f, 'a * 'b, 'D) r

  (* *)

  val tuple'2 : ('f, 'a, 'D) r -> ('f, 'b, 'D) r -> ('f, 'a * 'b, 'D) r

  val tuple'3 :
    ('f, 'a1, 'D) r ->
    ('f, 'a2, 'D) r ->
    ('f, 'a3, 'D) r ->
    ('f, 'a1 * 'a2 * 'a3, 'D) r

  val tuple'4 :
    ('f, 'a1, 'D) r ->
    ('f, 'a2, 'D) r ->
    ('f, 'a3, 'D) r ->
    ('f, 'a4, 'D) r ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4, 'D) r

  val tuple'5 :
    ('f, 'a1, 'D) r ->
    ('f, 'a2, 'D) r ->
    ('f, 'a3, 'D) r ->
    ('f, 'a4, 'D) r ->
    ('f, 'a5, 'D) r ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4 * 'a5, 'D) r

  val tuple'6 :
    ('f, 'a1, 'D) r ->
    ('f, 'a2, 'D) r ->
    ('f, 'a3, 'D) r ->
    ('f, 'a4, 'D) r ->
    ('f, 'a5, 'D) r ->
    ('f, 'a6, 'D) r ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4 * 'a5 * 'a6, 'D) r

  (* *)

  val unit : ('f, unit, 'D) r
  val do_unless : bool -> ('f, unit, 'D) r -> ('f, unit, 'D) r
  val do_when : bool -> ('f, unit, 'D) r -> ('f, unit, 'D) r

  (* *)

  val lift2 :
    ('a -> 'b -> 'c) -> ('f, 'a, 'D) r -> ('f, 'b, 'D) r -> ('f, 'c, 'D) r

  (* *)

  val thunk : (unit -> 'a) -> ('f, 'a, 'D) r
end
