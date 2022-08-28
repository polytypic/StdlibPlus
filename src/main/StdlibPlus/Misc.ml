module Syntax = struct
  let eq'2 (a, b) (s, t) = a == s && b == t
  let eq'3 (a, b, c) (s, t, u) = a == s && b == t && c == u
  let eq'4 (a, b, c, d) (s, t, u, v) = a == s && b == t && c == u && d == v
end
