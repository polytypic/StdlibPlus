open Method

let map_of
    (m :
      < return : 'a. ('f, 'a) return ; bind : 'a 'b. ('f, 'a, 'b) bind ; .. >)
    xy xF =
  xF |> m#bind @@ fun x -> m#return (xy x)

let pair_of
    (m :
      < map : 'a 'b. ('f, 'a, 'b) map ; bind : 'a 'b. ('f, 'a, 'b) bind ; .. >)
    xF yF =
  xF |> m#bind @@ fun x -> yF |> m#map @@ fun y -> (x, y)
