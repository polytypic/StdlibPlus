type 'a t = 'a

include
  Higher.New'1
    (struct
      type 'a t = 'a
    end)
    ()

let methods =
  object
    inherit [_] Monad.t
    method return = inj
    method bind xy x = inj (prj (xy (prj x)))
  end

type 'a mr = f Monad.t -> 'a f'1

let run xF = xF methods |> prj
