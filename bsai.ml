open Card

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
  let c = (string_to_suit "spades", int_to_rank n) in
  let play = List.filter (same_number c) hands in
  if play = []
  then ([List.hd hands], 1, int_to_rank n)
  else (play, List.length play, int_to_rank n)
