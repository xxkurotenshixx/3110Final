open Card
open Bsprint
open Bsai
open Hbs
open Bsupdater

let rec run_game s =
  if ai_win s
  then let _ = game_lost () in
       false
  else if p_win s
  then let _ = game_won () in
       true
  else
    try
      let cp = Bsupdater.cp s in
      let cn = Bsupdater.cn s in
      let _ = player_turn cp cn in
      let (cl, nc, tc) =
        (match cp with
         | 1 -> play_card cn (Bsupdater.p s 1)
         | 2 -> play_card cn (Bsupdater.p s 2)
         | 3 -> play_card cn (Bsupdater.p s 3)
         | _ -> let cn = Bsupdater.cn s in
                let p4 = Bsupdater.p s 4 in
                print_hand p4;
                what_cards cn;
                hand_format_prompt ();
                play_cards cn p4) in
      cards_played cp nc tc;
      if cp = 4
      then
        let (b, p) = call_bsp () in
        if b
        then let (bb, ns) = check_bs s cl nc tc p in
             bs_result bb p;
             run_game ns
        else run_game (no_bs cl s)
      else
        if call_bs (Bsupdater.p s 4)
        then let (bb,ns) = check_bs s cl nc tc 4 in
             hbs_result bb cp;
             run_game ns
        else run_game (no_bs cl s)
    with
    | _ -> false

let rec game_start () =
    if start ()
    then run_game (new_game ())
    else false

let run bet =
  welcome ();
  rules ();
  start_prompt ();
  if game_start ()
  then bet
  else -2 * bet
