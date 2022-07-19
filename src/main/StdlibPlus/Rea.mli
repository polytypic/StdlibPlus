open Misc.Syntax
include Higher.F'3

module Syntax : sig
  type ('r, 'e, 'a) rea = ('r, 'e) f'2 Monad.t -> ('r, 'e, 'a) f'3

  val start : 'r -> ('r, Zero.t, unit) rea -> unit

  (* *)

  val of_async : (('e -> unit) -> ('a -> unit) -> unit) -> ('r, 'e, 'a) rea
  val of_res : ('e, 'a) Res.t -> ('r, 'e, 'a) rea

  (* *)

  val fail : 'e -> ('r, 'e, 'a) rea

  (* *)

  val try_in :
    ('a -> ('r, 'f, 'b) rea) ->
    ('e -> ('r, 'f, 'b) rea) ->
    ('r, 'e, 'a) rea ->
    ('r, 'f, 'b) rea

  val catch : ('r, 'e, 'a) rea -> ('r, 'f, ('e, 'a) Res.t) rea

  (* *)

  val map_error : ('e -> 'f) -> ('r, 'e, 'a) rea -> ('r, 'f, 'a) rea
  val generalize_error : ('r, Zero.t, 'a) rea -> ('r, 'e, 'a) rea

  (* *)

  val env_as : ('r -> 'a) -> ('r, 'e, 'a) rea
  val map_env : ('r -> 's) -> ('s, 'e, 'a) rea -> ('r, 'e, 'a) rea
  val set_env : 's -> ('s, 'e, 'a) rea -> ('r, 'e, 'a) rea

  (* *)

  val invoke : ('r -> ('r, 'e, 'a) rea) -> ('r, 'e, 'a) rea

  (* *)

  val get : ((< .. > as 'r) -> 'v Oo.Prop.t) -> ('r, 'e, 'v) rea

  val get_as :
    ((< .. > as 'r) -> 'v Oo.Prop.t) -> ('v -> 'w) -> ('r, 'e, 'w) rea

  val setting : ((< .. > as 'r) -> 'v Oo.Prop.t) -> 'v -> ('r, 'e, 'a) rea uop

  val mapping :
    ((< .. > as 'r) -> 'v Oo.Prop.t) -> 'v uop -> ('r, 'e, 'a) rea uop

  module LVar : sig
    type ('e, 'a) t

    val create : ('r, 'e, 'a) rea -> ('r, 'f, ('e, 'a) t) rea
    val eval : ('e, 'a) t -> ('r, 'e, 'a) rea
  end

  module MVar : sig
    type 'v t

    val create : 'v -> 'v t
    val read : 'v t -> ('r, 'e, 'v) rea
    val mutate : ('v -> 'v) -> 'v t -> ('r, 'e, unit) rea
    val modify : ('v -> 'v * 'a) -> 'v t -> ('r, 'e, 'a) rea
    val try_mutate : ('v -> ('r, 'e, 'v) rea) -> 'v t -> ('r, 'e, unit) rea
    val try_modify : ('v -> ('r, 'e, 'v * 'a) rea) -> 'v t -> ('r, 'e, 'a) rea
  end

  val read : ((< .. > as 'r) -> 'v MVar.t Oo.Prop.t) -> ('r, 'e, 'v) rea

  val mutate :
    ((< .. > as 'r) -> 'v MVar.t Oo.Prop.t) -> ('v -> 'v) -> ('r, 'e, unit) rea

  val modify :
    ((< .. > as 'r) -> 'v MVar.t Oo.Prop.t) ->
    ('v -> 'v * 'a) ->
    ('r, 'e, 'a) rea

  val try_mutate :
    ((< .. > as 'r) -> 'v MVar.t Oo.Prop.t) ->
    ('v -> ('r, 'e, 'v) rea) ->
    ('r, 'e, unit) rea

  val try_modify :
    ((< .. > as 'r) -> 'v MVar.t Oo.Prop.t) ->
    ('v -> ('r, 'e, 'v * 'a) rea) ->
    ('r, 'e, 'a) rea
end
