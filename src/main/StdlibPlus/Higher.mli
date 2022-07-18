type ('f, 'x) t

module Syntax : sig
  type ('f, 'x1) app'1 = ('f, 'x1) t
  type ('f, 'x1, 'x2) app'2 = (('f, 'x1) t, 'x2) t
  type ('f, 'x1, 'x2, 'x3) app'3 = ((('f, 'x1) t, 'x2) t, 'x3) t
end

open Syntax

(* *)

module type T'1 = sig
  type 'x1 t
end

module type F'1 = sig
  type f
  type 'x1 t'1

  val inj : 'x1 t'1 -> (f, 'x1) app'1
  val prj : (f, 'x1) app'1 -> 'x1 t'1
end

module New'1 : functor (T'1 : T'1) () -> F'1 with type 'x1 t'1 = 'x1 T'1.t

(* *)

module type T'2 = sig
  type ('x1, 'x2) t
end

module type F'2 = sig
  type f
  type ('x1, 'x2) t'2

  val inj : ('x1, 'x2) t'2 -> (f, 'x1, 'x2) app'2
  val prj : (f, 'x1, 'x2) app'2 -> ('x1, 'x2) t'2
end

module New'2 (T'2 : T'2) () : F'2 with type ('x1, 'x2) t'2 = ('x1, 'x2) T'2.t

(* *)

module type T'3 = sig
  type ('x1, 'x2, 'x3) t
end

module type F'3 = sig
  type f
  type ('x1, 'x2, 'x3) t'3

  val inj : ('x1, 'x2, 'x3) t'3 -> (f, 'x1, 'x2, 'x3) app'3
  val prj : (f, 'x1, 'x2, 'x3) app'3 -> ('x1, 'x2, 'x3) t'3
end

module New'3 : functor (T'3 : T'3) () ->
  F'3 with type ('x1, 'x2, 'x3) t'3 = ('x1, 'x2, 'x3) T'3.t
