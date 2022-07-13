module Syntax = struct
  let failwithf fmt =
    fmt
    |> Printf.ksprintf @@ fun msg ->
       Printf.eprintf "Failure: %s\n" msg;
       failwith msg
end
