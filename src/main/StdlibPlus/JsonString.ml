open Exn.Syntax
open Fun.Syntax

type t = string

let compare = String.compare

(* *)

let of_utf8_json = Fun.id
let to_utf8_json = Fun.id

(* *)

let of_utf8 str =
  let buffer = Buffer.create (String.length str * 2) in
  let add_uchar = Buffer.add_utf_8_uchar buffer in
  let to_hex i =
    Uchar.of_int
      (i
      +
      if 0 <= i && i <= 9 then Uchar.to_int (Uchar.of_char '0')
      else Uchar.to_int (Uchar.of_char 'a') - 10)
  in
  add_uchar @@ Uchar.of_char '"';
  let rec loop i =
    if i < String.length str then
      let decode = String.get_utf_8_uchar str i in
      if Uchar.utf_decode_is_valid decode then (
        let u = Uchar.utf_decode_uchar decode in
        let c = Uchar.to_int u in
        if (0x0000 <= c && c <= 0x001f) || (0x007f <= c && c <= 0x009f) then (
          add_uchar @@ Uchar.of_char '\\';
          if u = Uchar.of_char '\b' then add_uchar @@ Uchar.of_char 'b'
          else if u = Uchar.of_int 0x0c then add_uchar @@ Uchar.of_char 'f'
          else if u = Uchar.of_char '\n' then add_uchar @@ Uchar.of_char 'n'
          else if u = Uchar.of_char '\r' then add_uchar @@ Uchar.of_char 'r'
          else if u = Uchar.of_char '\t' then add_uchar @@ Uchar.of_char 't'
          else (
            add_uchar @@ Uchar.of_char 'u';
            add_uchar @@ to_hex ((c lsr 12) land 0xf);
            add_uchar @@ to_hex ((c lsr 8) land 0xf);
            add_uchar @@ to_hex ((c lsr 4) land 0xf);
            add_uchar @@ to_hex ((c lsr 0) land 0xf)))
        else if Uchar.of_char '"' = u || Uchar.of_char '\\' = u then (
          add_uchar @@ Uchar.of_char '\\';
          add_uchar u)
        else add_uchar u;
        loop (i + Uchar.utf_decode_length decode))
      else failwithf "Malformed UTF-8 in string at char index %d" i
  in
  loop 0;
  add_uchar @@ Uchar.of_char '"';
  Buffer.contents buffer

let to_utf8 lit =
  let buffer = Buffer.create (String.length lit * 2) in
  let add_uchar = Buffer.add_utf_8_uchar buffer in
  let hex_to_int h c =
    (h lsl 4)
    lor
    if Uchar.of_char '0' <= c && c <= Uchar.of_char '9' then
      Uchar.to_int c - Uchar.to_int (Uchar.of_char '0')
    else if Uchar.of_char 'a' <= c && c <= Uchar.of_char 'f' then
      Uchar.to_int c - Uchar.to_int (Uchar.of_char 'a') + 10
    else Uchar.to_int c - Uchar.to_int (Uchar.of_char 'A') + 10
  in
  let is_white c =
    Uchar.of_char ' ' = c
    || Uchar.of_char '\t' = c
    || Uchar.of_char '\n' = c
    || Uchar.of_char '\r' = c
  in
  let rec loop i s =
    if i < String.length lit then
      let decode = String.get_utf_8_uchar lit i in
      if Uchar.utf_decode_is_valid decode then
        let c = Uchar.utf_decode_uchar decode in
        let i = i + Uchar.utf_decode_length decode in
        let encode c =
          add_uchar c;
          loop i `Unescaped
        in
        match s with
        | `Unescaped ->
          if Uchar.of_char '\\' = c then loop i `Escaped
          else if Uchar.of_char '"' = c then loop i `Unescaped
          else if Uchar.of_char '\n' = c || Uchar.of_char '\r' = c then (
            add_uchar (Uchar.of_char '\n');
            loop i `Escaped)
          else encode c
        | `Escaped ->
          if
            Uchar.of_char '"' = c
            || Uchar.of_char '\\' = c
            || Uchar.of_char '/' = c
          then encode c
          else if Uchar.of_char 'b' = c then encode (Uchar.of_char '\b')
          else if Uchar.of_char 'f' = c then encode (Uchar.of_int 0x0c)
          else if Uchar.of_char 'n' = c then encode (Uchar.of_char '\n')
          else if Uchar.of_char 'r' = c then encode (Uchar.of_char '\r')
          else if Uchar.of_char 't' = c then encode (Uchar.of_char '\t')
          else if is_white c then loop i `Continued
          else loop i `Hex0
        | `Continued -> loop i (if is_white c then `Continued else `Unescaped)
        | `Hex0 -> loop i @@ `Hex1 (hex_to_int 0 c)
        | `Hex1 h -> loop i @@ `Hex2 (hex_to_int h c)
        | `Hex2 h -> loop i @@ `Hex3 (hex_to_int h c)
        | `Hex3 h -> encode (Uchar.of_int (hex_to_int h c))
      else failwithf "Malformed UTF-8 in string literal at char index %d" i
  in
  loop 0 `Unescaped;
  Buffer.contents buffer

(* *)

let of_utf8_json_literal = of_utf8_json >>> to_utf8 >>> of_utf8

(* *)

let empty = of_utf8_json "\"\""
let is_empty x = x = empty
