let call_bs () = Random.int 3 = 0

let call_bsp () =
  if call_bs ()
  then (true, 1)
  else if call_bs ()
  then (true, 2)
  else if call_bs ()
  then (true, 3)
  else (false, 0)

let play_card n hands =
  let c = (Spades, int_to_rank n) in
  let play = List.filter (Card.same_number c) hands in
  if play = []
  then ([List.hd hands], 1, Card.int_to_rank n)
  else (play, List.length play, Card.int_to_rank n)
