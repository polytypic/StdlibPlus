type ('e, 'a) t = [`Ok of 'a | `Error of 'e]

let catch thunk = match thunk () with v -> `Ok v | exception e -> `Error e
