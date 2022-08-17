open Exn.Syntax
open Fun.Syntax

let encode_with add_uchar chars =
  let buffer = Buffer.create (Array.length chars * 2) in
  Array.iter (add_uchar buffer) chars;
  buffer

let decode_with m length get input =
  let buffer = Array.make (length input) Uchar.min in
  let rec loop i j =
    if i < length input then
      let decode = get input i in
      if Uchar.utf_decode_is_valid decode then (
        buffer.(j) <- Uchar.utf_decode_uchar decode;
        loop (i + Uchar.utf_decode_length decode) (j + 1))
      else failwithf "Malformed UTF-%s at char index %d" m i
    else j
  in
  let n = loop 0 0 in
  if n <> Array.length buffer then Array.sub buffer 0 n else buffer

module UTF8 = struct
  let of_uchar_array = encode_with Buffer.add_utf_8_uchar >>> Buffer.contents
  let to_uchar_array = decode_with "8" String.length String.get_utf_8_uchar
end

module UTF16 = struct
  let of_uchar_array = encode_with Buffer.add_utf_16be_uchar >>> Buffer.to_bytes
  let to_uchar_array = decode_with "16" Bytes.length Bytes.get_utf_16be_uchar
end
