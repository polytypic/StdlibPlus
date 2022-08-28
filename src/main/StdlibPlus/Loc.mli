open Concepts.Syntax

type t = Pos.t * Pos.t

(* Comparison *)

include OrderedType with type t := t
include EqualityType with type t := t

val is_dummy : t -> bool
val is_empty : t -> bool

(* Constructors *)

val of_path : string -> t
val dummy : t
val union : t -> t -> t

(* Accessors *)

val path : t -> string
