open Bjprinter
open Bjupdater
open Hbj
open Parser

let rec player_turn s =
  if pbust s then s
  else
    let _ =
      player_prompt ();
      print_hand (player s) "You have:\n";
      print_hand [(List.nth (dealer s) 0)] "The visible card is: \n" in
    if play (get_wallet s)
    then let ns = hit s "player" in player_turn ns
    else s

let rec dealer_turn s =
  if ddraw s
  then
    let ns = hit s "dealer" in
    if dbust ns then ns
    else dealer_turn ns
  else s

let rec p_lost_tie s =
  if confirm () then runner s else s

and d_lost bid s =
  round_won ();
  if confirm () then runner (add_win bid s) else add_win bid s

and status s bid =
  print_hand (player s) " You had:\n";
  print_hand (dealer s) "\n The dealer had:\n";
  match win s with
  | 0 -> game_tie (); p_lost_tie s
  | 1 -> d_lost bid s
  | _ -> round_lost (); p_lost_tie s

and runner s =
  if (get_wallet s) >= 50 then
    let  _ = bid_prompt () in
    try
      let bet = bid (get_wallet s) in
      let ns = new_game_deal bet s in
      if (pbust ns || dbust ns) then status ns bet
      else
        try
          let ps = player_turn ns in
          if pbust ps then status ps bet
          else status (dealer_turn ps) bet
        with
        | _ -> ns
    with
    | _ -> s
  else let _ = not_enuf_mon () in s

let run money =
  welcome ();
  rules ();
  start_prompt ();
  if start money
  then
    let s = runner (new_table money) in
    leave money (get_wallet s) (rounds s);
    (get_wallet s)
  else
    money
