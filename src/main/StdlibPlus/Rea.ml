open Fun.Syntax
open Monad.Syntax

type (-'r, +'e, +'a) t =
  | Fail : 'e -> ('r, 'e, 'a) t
  | Return : 'a -> ('r, 'e, 'a) t
  | Bind : ('r, 'e, 'b) t * ('b -> ('r, 'e, 'a) t) -> ('r, 'e, 'a) t
  | TryIn :
      ('r, 'f, 'b) t * ('b -> ('r, 'e, 'a) t) * ('f -> ('r, 'e, 'a) t)
      -> ('r, 'e, 'a) t
  | Env : ('r -> ('r, 'e, 'a) t) -> ('r, 'e, 'a) t
  | MapEnv : ('r -> 's) * ('s, 'e, 'a) t -> ('r, 'e, 'a) t
  | Async : ((('e, 'a) Res.t -> work) -> unit) -> ('r, 'e, 'a) t

and work = Work : 'r * ('r, Zero.t, unit) t -> work

let work = ref []
let running = ref false

let rec pop () =
  match !work with
  | Work (r, xF) :: ws ->
    work := ws;
    start' (r, xF)
  | [] -> running := false

and start' : 'r. 'r * ('r, 'e, 'a) t -> unit =
 fun (r, xF) ->
  match xF with
  | Fail _ | Return _ -> pop ()
  | Env rxF -> start' (r, rxF r)
  | MapEnv (rs, xF) -> start' (rs r, xF)
  | Async on ->
    on (fun _ -> Work ((), Return ()));
    pop ()
  | TryIn (xF, xyF, eyF) -> (
    match xF with
    | Return x -> start' (r, xyF x)
    | Fail e -> start' (r, eyF e)
    | Env rxF -> start' (r, TryIn (rxF r, xyF, eyF))
    | MapEnv (rs, xF) ->
      start'
        ( rs r,
          TryIn
            ( xF,
              (fun x -> MapEnv (const r, xyF x)),
              fun e -> MapEnv (const r, eyF e) ) )
    | Async on ->
      on (function `Ok x -> Work (r, xyF x) | `Error e -> Work (r, eyF e));
      pop ()
    | Bind (zF, zxF) ->
      start' (r, TryIn (zF, (fun z -> TryIn (zxF z, xyF, eyF)), eyF))
    | TryIn (zF, zxF, exF) ->
      start'
        ( r,
          TryIn
            ( zF,
              (fun z -> TryIn (zxF z, xyF, eyF)),
              fun e -> TryIn (exF e, xyF, eyF) ) ))
  | Bind (xF, xyF) -> (
    match xF with
    | Fail _ -> ()
    | Return x -> start' (r, xyF x)
    | Env rxF -> start' (r, Bind (rxF r, xyF))
    | MapEnv (rs, xF) ->
      start' (rs r, Bind (xF, fun x -> MapEnv (const r, xyF x)))
    | Async on ->
      on (function `Ok x -> Work (r, xyF x) | `Error _ -> .);
      pop ()
    | Bind (zF, zxF) -> start' (r, Bind (zF, fun z -> Bind (zxF z, xyF)))
    | TryIn (zF, zxF, exF) ->
      start'
        (r, TryIn (zF, (fun z -> Bind (zxF z, xyF)), fun e -> Bind (exF e, xyF)))
    )

let push (Work (r, xF) as w) =
  if !running then work := w :: !work
  else (
    running := true;
    start' (r, xF))

(* *)

include
  Higher.New'3
    (struct
      type nonrec ('r, 'e, 'a) t = ('r, 'e, 'a) t
    end)
    ()

let methods =
  let open Method in
  object (m)
    method return : 'a. (_, 'a) return = fun x -> inj (Return x)

    method bind : 'a 'b. (_, 'a, 'b) bind =
      fun xyF xF -> inj @@ Bind (prj xF, fun x -> prj (xyF x))

    method map : 'a 'b. (_, 'a, 'b) map = Default.map_of m
    method pair : 'a 'b. (_, 'a, 'b) pair = Default.pair_of m
    method branch : 'a 'b 'c. (_, 'a, 'b, 'c) branch = Default.branch_of m
  end

let run xF = xF methods |> prj

module Syntax = struct
  type ('r, 'e, 'a) rea = ('r, 'e) f'2 Monad.t -> ('r, 'e, 'a) f'3

  let start r (uF : (_, _, _) rea) = push @@ Work (r, run uF)

  (* *)

  let of_async op : (_, _, _) rea =
   fun _ ->
    inj
    @@ Async
         (fun k ->
           op (fun e -> push @@ k @@ `Error e) (fun a -> push @@ k @@ `Ok a))

  let of_res x _ = inj @@ match x with `Ok x -> Return x | `Error e -> Fail e

  (* *)

  let fail e : (_, _, _) rea = fun _ -> Fail e |> inj

  (* *)

  let try_in xyF eyF xF : (_, _, _) rea =
   fun _ -> inj @@ TryIn (run xF, xyF >>> run, eyF >>> run)

  let catch xF : (_, _, _) rea =
   fun _ ->
    inj @@ TryIn (run xF, (fun x -> Return (`Ok x)), fun e -> Return (`Error e))

  (* *)

  let map_error ef xF : (_, _, _) rea =
   fun _ -> inj @@ TryIn (run xF, (fun x -> Return x), fun e -> Fail (ef e))

  let generalize_error xF = map_error (function (_ : Zero.t) -> .) xF

  (* *)

  let env_as ra : (_, _, _) rea = fun _ -> inj @@ Env (fun r -> Return (ra r))

  let map_env rs (xF : (_, _, _) rea) : (_, _, _) rea =
   fun _ -> inj @@ MapEnv (rs, run xF)

  let set_env r = map_env (const r)

  (* *)

  let invoke (raF : 'r -> ('r, 'e, 'a) rea) : ('r, 'e, 'a) rea =
   fun _ -> inj @@ Env (fun r -> run (raF r))

  (* *)

  let get f = env_as (Oo.Prop.get f)
  let get_as f fn = env_as (Oo.Prop.get f >>> fn)
  let setting f x = map_env @@ Oo.Prop.set f x
  let mapping f fn = map_env @@ Oo.Prop.map f fn

  module LVar = struct
    type ('e, 'a) state =
      [ `Initial of work
      | `Empty of (('e, 'a) Res.t -> work) list
      | ('e, 'a) Res.t ]

    type ('e, 'a) t = ('e, 'a) state ref

    let create (op : (_, _, _) rea) : (_, _, (_, _) t) rea =
     fun _ ->
      inj
      @@ Env
           (fun r ->
             let var = ref (`Empty []) in
             var :=
               `Initial
                 (Work
                    ( r,
                      TryIn
                        ( run op,
                          (fun x ->
                            let res = `Ok x in
                            match !var with
                            | `Empty ks ->
                              var := (res :> (_, _) state);
                              ks |> List.iter (fun k -> push @@ k res);
                              Return ()
                            | _ -> failwith "LVar.create"),
                          fun e ->
                            let res = `Error e in
                            match !var with
                            | `Empty ks ->
                              var := (res :> (_, _) state);
                              ks |> List.iter (fun k -> push @@ k res);
                              Return ()
                            | _ -> failwith "LVar.create" ) ));
             Return var)

    let eval (var : _ t) : (_, _, _) rea =
     fun _ ->
      inj
      @@
      match !var with
      | `Ok x -> Return x
      | `Error e -> Fail e
      | `Initial _ ->
        Async
          (fun k ->
            match !var with
            | (`Ok _ | `Error _) as x -> push @@ k x
            | `Empty ks -> var := `Empty (k :: ks)
            | `Initial ef ->
              var := `Empty [k];
              push ef)
      | `Empty _ ->
        Async
          (fun k ->
            match !var with
            | (`Ok _ | `Error _) as x -> push @@ k x
            | `Empty ks -> var := `Empty (k :: ks)
            | _ -> failwith "LVar.get")
  end

  module MVar = struct
    type 'v state = [`Empty of ([`Ok of 'v] -> work) list | `Ok of 'v]
    type 'v t = 'v state ref

    let create v = ref @@ `Ok v
    let empty = `Empty []

    let take (var : _ t) : (_, _, _) t'3 =
      match !var with
      | `Ok x ->
        var := empty;
        Return x
      | `Empty _ ->
        Async
          (fun k ->
            match !var with
            | `Ok _ as x ->
              var := empty;
              push @@ k x
            | `Empty ks -> var := `Empty ((k :> [`Ok of 'v] -> work) :: ks))

    let fill (var : _ t) v =
      let ok = `Ok v in
      match !var with
      | `Empty [] -> var := ok
      | `Empty (k :: ks) ->
        var := `Empty ks;
        push @@ k ok
      | _ -> failwith "MVar.fill"

    let read (var : 'v t) : (_, _, 'v) rea =
     fun _ ->
      inj
      @@ Bind
           ( take var,
             fun v ->
               fill var v;
               Return v )

    let mutate fn (var : _ t) : (_, _, _) rea =
     fun _ ->
      inj
      @@ Bind
           ( take var,
             fun v ->
               fill var (fn v);
               Return () )

    let modify fn (var : _ t) : (_, _, _) rea =
     fun _ ->
      inj
      @@ Bind
           ( take var,
             fun v ->
               let v, a = fn v in
               fill var v;
               Return a )

    let try_mutate fn (var : _ t) : (_, _, _) rea =
     fun _ ->
      inj
      @@ Bind
           ( take var,
             fun v ->
               TryIn
                 ( run (fn v),
                   (fun v ->
                     fill var v;
                     Return ()),
                   fun e ->
                     fill var v;
                     Fail e ) )

    let try_modify fn (var : _ t) : (_, _, _) rea =
     fun _ ->
      inj
      @@ Bind
           ( take var,
             fun v ->
               TryIn
                 ( run (fn v),
                   (fun (v, a) ->
                     fill var v;
                     Return a),
                   fun e ->
                     fill var v;
                     Fail e ) )
  end

  let read v = get v >>= MVar.read
  let mutate v fn = get v >>= MVar.mutate fn
  let modify v fn = get v >>= MVar.modify fn
  let try_mutate v fn = get v >>= MVar.try_mutate fn
  let try_modify v fn = get v >>= MVar.try_modify fn
end
