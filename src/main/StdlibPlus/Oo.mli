include module type of Stdlib.Oo

module Prop : sig
  type 'a t

  val get : ((< .. > as 'r) -> 'a t) -> 'r -> 'a
  val set : ((< .. > as 'r) -> 'a t) -> 'a -> 'r -> 'r
  val map : ((< .. > as 'r) -> 'a t) -> ('a -> 'a) -> 'r -> 'r
end

module Syntax : sig
  val prop : (unit -> 'a) -> ('a -> unit) -> 'a Prop.t
end
