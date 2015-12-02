open Card
open Bsprint
open Bsai
open Hbs
open Bsupdater
module Bullshit = struct

  let rec run_game s =
    if Bsupdater.ai_win s
    then let _ = Bsprint.game_lost () in
         false
    else if Bsupdater.p_win s
    then let _ = Bsprint.game_won () in
         true
    else
      try
        let cp = Bsupdater.cp s in
        let cn = Bsupdater.cn s in
        let _ = Bsprint.player_turn cp cn in
        let (cl, nc, tc) = (match cp with
                            | 1 -> Bsai.play_card cn (Bsupdater.p s 1)
                            | 2 -> Bsai.play_card cn (Bsupdater.p s 2)
                            | 3 -> Bsai.play_card cn (Bsupdater.p s 3)
                            | _ -> let cn = Bsupdater.cn s in
                                   let p4 = Bsupdater.p s 4 in
                                   Bsprint.print_hand p4;
                                   Bsprint.what_cards cn;
                                   Hbs.play_cards cn p4) in
        Bsprint.cards_played cp nc tc;
        if cp = 4
        then
          let (b, p) = Bsai.call_bsp () in
          if b
          then let (bb, ns) = Bsupdater.check_bs s cl nc tc p in
               Bsprint.bs_result bb p;
               run_game ns
          else run_game (Bsupdater.no_bs cl s)
        else
          if Hbs.call_bs (Bsupdater.p s 4)
          then let (bb,ns) = Bsupdater.check_bs s cl nc tc 4 in
               Bsprint.hbs_result bb cp;
               run_game ns
          else run_game (Bsupdater.no_bs cl s)
      with
      | _ -> false

  let rec game_start () =
    if Hbs.start ()
    then run_game (Bsupdater.new_game ())
    else false

  let run bid =
    Bsprint.rules ();
    if game_start ()
    then bid
    else -2 * bid
end
