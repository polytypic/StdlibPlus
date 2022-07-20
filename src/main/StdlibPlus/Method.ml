open Higher.Syntax

(* *)

type ('f, 'a, 'b) map = ('a -> 'b) -> ('f, 'a) app'1 -> ('f, 'b) app'1
type ('f, 'a) return = 'a -> ('f, 'a) app'1
type ('f, 'a, 'b) pair = ('f, 'a) app'1 -> ('f, 'b) app'1 -> ('f, 'a * 'b) app'1

type ('f, 'a, 'b) bind =
  ('a -> ('f, 'b) app'1) -> ('f, 'a) app'1 -> ('f, 'b) app'1

(* *)

type ('f, 'a) zero = ('f, 'a) app'1
type ('f, 'a) alt = ('f, 'a) app'1 -> ('f, 'a) app'1 -> ('f, 'a) app'1

(* *)

type 'a identity = 'a
type 'a combine = 'a -> 'a -> 'a
