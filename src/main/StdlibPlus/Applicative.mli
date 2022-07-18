open Higher.Syntax

type ('f, 'a) return = 'a -> ('f, 'a) app'1
type ('f, 'a, 'b) pair = ('f, 'a) app'1 -> ('f, 'b) app'1 -> ('f, 'a * 'b) app'1

type 'f t =
  < 'f Functor.t
  ; return : 'a. ('f, 'a) return
  ; pair : 'a 'b. ('f, 'a, 'b) pair >

type ('f, 'a, 'D) fr = (< 'f t ; .. > as 'D) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'a, 'f t) fr

module Syntax : sig
  val return : 'a -> ('f, 'a, 'D) fr
  val ( and+ ) : ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr -> ('f, 'a * 'b, 'D) fr

  (* *)

  val ( <*> ) : ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr -> ('f, 'a * 'b, 'D) fr

  (* *)

  val tuple'2 : ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr -> ('f, 'a * 'b, 'D) fr

  val tuple'3 :
    ('f, 'a1, 'D) fr ->
    ('f, 'a2, 'D) fr ->
    ('f, 'a3, 'D) fr ->
    ('f, 'a1 * 'a2 * 'a3, 'D) fr

  val tuple'4 :
    ('f, 'a1, 'D) fr ->
    ('f, 'a2, 'D) fr ->
    ('f, 'a3, 'D) fr ->
    ('f, 'a4, 'D) fr ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4, 'D) fr

  val tuple'5 :
    ('f, 'a1, 'D) fr ->
    ('f, 'a2, 'D) fr ->
    ('f, 'a3, 'D) fr ->
    ('f, 'a4, 'D) fr ->
    ('f, 'a5, 'D) fr ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4 * 'a5, 'D) fr

  val tuple'6 :
    ('f, 'a1, 'D) fr ->
    ('f, 'a2, 'D) fr ->
    ('f, 'a3, 'D) fr ->
    ('f, 'a4, 'D) fr ->
    ('f, 'a5, 'D) fr ->
    ('f, 'a6, 'D) fr ->
    ('f, 'a1 * 'a2 * 'a3 * 'a4 * 'a5 * 'a6, 'D) fr

  (* *)

  val unit : ('f, unit, 'D) fr
  val do_unless : bool -> ('f, unit, 'D) fr -> ('f, unit, 'D) fr
  val do_when : bool -> ('f, unit, 'D) fr -> ('f, unit, 'D) fr

  (* *)

  val lift2 :
    ('a -> 'b -> 'c) -> ('f, 'a, 'D) fr -> ('f, 'b, 'D) fr -> ('f, 'c, 'D) fr

  (* *)

  val thunk : (unit -> 'a) -> ('f, 'a, 'D) fr
end
