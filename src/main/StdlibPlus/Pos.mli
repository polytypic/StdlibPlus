open Concepts.Syntax

type t = Lexing.position

(* Constructors *)

val of_path : string -> t

(* Accessors *)

val column_of : t -> int

(* Comparison *)

include OrderedType with type t := t
include EqualityType with type t := t

(* *)

val add_cnum : int -> t -> t
val sub_cnum : int -> t -> t
