open Rea

val test :
  string ->
  (unit -> (Tailrec.r, exn, unit, ('D Tailrec.async as 'D)) er) ->
  unit

val verify :
  bool -> ('R, exn, unit, (< ('R, 'D) pure' ; ('R, 'D) fail' ; .. > as 'D)) er

val failure : string -> ('R, exn, 'a, (('R, 'D) #fail' as 'D)) er

val failuref :
  ( 'a,
    unit,
    string,
    string,
    string,
    ('R, exn, 'b, (('R, 'D) #fail' as 'D)) er )
  format6 ->
  'a
