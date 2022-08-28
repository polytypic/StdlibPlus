open Concepts.Syntax

type t

val str : string -> t
val ( ^ ) : t -> t -> t

include StringableType with type t := t
