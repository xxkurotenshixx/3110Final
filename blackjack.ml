module Blackjack = struct

  let rec player_turn s =
    let (play,cl) = Hbj.play (Bjupdater.deck s) (Bjupdater.player s) in
    if play
    then

  let run_round bid os =
    let s = Bjupdater.new_game_deal os in
    let cl = Hbj.

  let rec runner money =
    Bjprinter.rules ();
    Bjprinter.start_prompt ();
    let (start,bid) = Hbj.start () in
    if start
    then


  let run money =
    Bjprinter.welcome ();
    let (money_left,rounds) = runner money in
    Bjprinter.leave money money_left rounds;
    money_left
end
