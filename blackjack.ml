module Blackjack = struct

  let rec player_turn s =
    let (play,cl) = Hbj.play (Bjupdater.deck s) (Bjupdater.player s) in
    if play
    then

  let run_round bid os =
    let s = Bjupdater.new_game_deal bid os in
    let cl = player_turn os

  let runner s =
    Bjprinter.start_prompt ();
    let bid = Hbj.start Bjupdater.money s in
    if bid > 0
    then
      run_round bid s
    else
      s

  let run money =
    Bjprinter.welcome ();
    Bjprinter.rules ();
    let s = runner (Bjupdater.new_table money) in
    Bjprinter.leave money (Bjupdater.money s) (Bjupdater.rounds s);
    Bjupdater.money s
end
