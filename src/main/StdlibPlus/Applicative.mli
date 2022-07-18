open Higher.Syntax

type ('f, 'a) return = 'a -> ('f, 'a) app'1
type ('f, 'a, 'b) pair = ('f, 'a) app'1 -> ('f, 'b) app'1 -> ('f, 'a * 'b) app'1

type 'f t =
  < 'f Functor.t
  ; return : 'a. ('f, 'a) return
  ; pair : 'a 'b. ('f, 'a, 'b) pair >

type ('f, 'F, 'a) fr = (< 'f t ; .. > as 'F) -> ('f, 'a) app'1
type ('f, 'a) frm = ('f, 'f t, 'a) fr

module Syntax : sig
  val return : 'a -> ('f, 'F, 'a) fr
  val ( and+ ) : ('f, 'F, 'a) fr -> ('f, 'F, 'b) fr -> ('f, 'F, 'a * 'b) fr

  (* *)

  val ( <*> ) : ('f, 'F, 'a) fr -> ('f, 'F, 'b) fr -> ('f, 'F, 'a * 'b) fr

  (* *)

  val tuple'2 : ('f, 'F, 'a) fr -> ('f, 'F, 'b) fr -> ('f, 'F, 'a * 'b) fr

  val tuple'3 :
    ('f, 'F, 'a1) fr ->
    ('f, 'F, 'a2) fr ->
    ('f, 'F, 'a3) fr ->
    ('f, 'F, 'a1 * 'a2 * 'a3) fr

  val tuple'4 :
    ('f, 'F, 'a1) fr ->
    ('f, 'F, 'a2) fr ->
    ('f, 'F, 'a3) fr ->
    ('f, 'F, 'a4) fr ->
    ('f, 'F, 'a1 * 'a2 * 'a3 * 'a4) fr

  val tuple'5 :
    ('f, 'F, 'a1) fr ->
    ('f, 'F, 'a2) fr ->
    ('f, 'F, 'a3) fr ->
    ('f, 'F, 'a4) fr ->
    ('f, 'F, 'a5) fr ->
    ('f, 'F, 'a1 * 'a2 * 'a3 * 'a4 * 'a5) fr

  val tuple'6 :
    ('f, 'F, 'a1) fr ->
    ('f, 'F, 'a2) fr ->
    ('f, 'F, 'a3) fr ->
    ('f, 'F, 'a4) fr ->
    ('f, 'F, 'a5) fr ->
    ('f, 'F, 'a6) fr ->
    ('f, 'F, 'a1 * 'a2 * 'a3 * 'a4 * 'a5 * 'a6) fr

  (* *)

  val unit : ('f, 'F, unit) fr
  val do_unless : bool -> ('f, 'F, unit) fr -> ('f, 'F, unit) fr
  val do_when : bool -> ('f, 'F, unit) fr -> ('f, 'F, unit) fr

  (* *)

  val lift2 :
    ('a -> 'b -> 'c) -> ('f, 'F, 'a) fr -> ('f, 'F, 'b) fr -> ('f, 'F, 'c) fr

  (* *)

  val thunk : (unit -> 'a) -> ('f, 'F, 'a) fr
end
