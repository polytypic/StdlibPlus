type 'a t = 'a

include
  Higher.New'1
    (struct
      type 'a t = 'a
    end)
    ()

let methods =
  let open Method in
  object
    method map : 'a 'b. (_, 'a, 'b) map = fun xy xF -> inj (xy (prj xF))
    method return : 'a. (_, 'a) return = inj
    method pair : 'a 'b. (_, 'a, 'b) pair = fun xF yF -> inj (prj xF, prj yF)
    method bind : 'a 'b. (_, 'a, 'b) bind = fun xy x -> inj (prj (xy (prj x)))
  end

type 'a mr = f Monad.t -> 'a f'1

let run xF = xF methods |> prj
