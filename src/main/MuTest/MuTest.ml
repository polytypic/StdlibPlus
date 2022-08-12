open Rea
open StdlibPlus

(* *)

let n_tests = ref 0
let n_successes = ref 0
let n_failures = ref 0

(* *)

let tests :
    (string * (Tailrec.r, exn, unit, ('D Tailrec.async as 'D)) er) list ref =
  ref []

(* *)

let inc x = x := !x + 1
let push_to xs x = xs := x :: !xs

let pop_all xs =
  let all = !xs in
  xs := [];
  all

let () =
  at_exit @@ fun () ->
  pop_all tests |> List.rev
  |> List.iter_er (fun (name, test) ->
         test
         |> tryin
              (fun exn ->
                inc n_failures;
                (match exn with
                | Failure msg -> msg
                | exn -> Printexc.to_string exn)
                |> String.split_on_char '\n'
                |> List.map (fun line -> "    " ^ line)
                |> String.concat "\n"
                |> Printf.printf "[FAIL] %s:\n\n%s\n\n" name;
                unit)
              (fun () ->
                inc n_successes;
                Printf.printf "  [OK] %s\n" name;
                unit))
  >>- (fun () ->
        if !n_failures = 0 then
          Printf.printf "Ran %d tests.  No failures.\n" !n_tests
        else (
          Printf.printf "Ran %d tests:\n- %d successes, and\n- %d failures.\n"
            !n_tests !n_successes !n_failures;
          exit 1))
  |> Tailrec.spawn Tailrec.async

let test name effect =
  let test = eta'0 @@ fun () -> try effect () with exn -> fail exn in
  inc n_tests;
  push_to tests (name, test)

let failure m = fail @@ Failure m
let failuref fmt = Printf.ksprintf failure fmt
let verify b = if not b then failure "verify false" else unit
