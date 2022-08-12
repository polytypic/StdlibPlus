open Rea

module Syntax = struct
  module type Traversable'1 = sig
    type 'x1 f'1

    val map_er'1 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      'x11 f'1 ->
      ('R, 'e, 'x12 f'1, 'D) er
  end

  module type Traversable'2 = sig
    type ('x1, 'x2) f'2

    val map_er'2 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      ('x21 -> ('R, 'e, 'x22, 'D) er) ->
      ('x11, 'x21) f'2 ->
      ('R, 'e, ('x12, 'x22) f'2, 'D) er
  end

  module type Traversable'3 = sig
    type ('x1, 'x2, 'x3) f'3

    val map_er'3 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      ('x21 -> ('R, 'e, 'x22, 'D) er) ->
      ('x31 -> ('R, 'e, 'x32, 'D) er) ->
      ('x11, 'x21, 'x31) f'3 ->
      ('R, 'e, ('x12, 'x22, 'x32) f'3, 'D) er
  end

  module type Traversable'4 = sig
    type ('x1, 'x2, 'x3, 'x4) f'4

    val map_er'4 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      ('x21 -> ('R, 'e, 'x22, 'D) er) ->
      ('x31 -> ('R, 'e, 'x32, 'D) er) ->
      ('x41 -> ('R, 'e, 'x42, 'D) er) ->
      ('x11, 'x21, 'x31, 'x41) f'4 ->
      ('R, 'e, ('x12, 'x22, 'x32, 'x42) f'4, 'D) er
  end

  module type Traversable'5 = sig
    type ('x1, 'x2, 'x3, 'x4, 'x5) f'5

    val map_er'5 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      ('x21 -> ('R, 'e, 'x22, 'D) er) ->
      ('x31 -> ('R, 'e, 'x32, 'D) er) ->
      ('x41 -> ('R, 'e, 'x42, 'D) er) ->
      ('x51 -> ('R, 'e, 'x52, 'D) er) ->
      ('x11, 'x21, 'x31, 'x41, 'x51) f'5 ->
      ('R, 'e, ('x12, 'x22, 'x32, 'x42, 'x52) f'5, 'D) er
  end

  module type Traversable'6 = sig
    type ('x1, 'x2, 'x3, 'x4, 'x5, 'x6) f'6

    val map_er'6 :
      ('x11 -> ('R, 'e, 'x12, (('R, 'D) #applicative' as 'D)) er) ->
      ('x21 -> ('R, 'e, 'x22, 'D) er) ->
      ('x31 -> ('R, 'e, 'x32, 'D) er) ->
      ('x41 -> ('R, 'e, 'x42, 'D) er) ->
      ('x51 -> ('R, 'e, 'x52, 'D) er) ->
      ('x61 -> ('R, 'e, 'x62, 'D) er) ->
      ('x11, 'x21, 'x31, 'x41, 'x51, 'x61) f'6 ->
      ('R, 'e, ('x12, 'x22, 'x32, 'x42, 'x52, 'x62) f'6, 'D) er
  end
end
