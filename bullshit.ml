open Card
open Bsprint
open Bsai
open Hbs
open Deck
open Bsupdater

type state = {p1 : Card.card list; p2 : Card.card list; p3 : Card.card list;
              p4 : Card.card list; c : Card.card list; cn : int; cp: int}

let rec run_game s =
  if (s.p1 = [] || s.p2 = [] || s.p3 = []) && s.p4 <> []
  then let _ = Bsprint.game_lost () in
       false
  else if s.p4 = []
  then let _ = Bsprint.game_won () in
       true
  else
    try
      let _ = Bsprint.player_turn s.cp s.cn in
      let (cl, nc, tc) = (match s.cp with
        | 1 -> Bsai.play_card s.cn s.p1
        | 2 -> Bsai.play_card s.cn s.p2
        | 3 -> Bsai.play_card s.cn s.p3
        | _ -> Bsprint.print_hand s.p4;
               Bsprint.what_cards s.cn;
               Hbs.play_cards s.cn s.p4) in
      Bsprint.cards_played s.cp nc tc;
      if s.cp = 4
      then
        let (b, p) = Bsai.call_bsp () in
        if b
        then let (bb, ns) = Bsupdater.check_bs s cl nc tc p in
             Bsprint.bs_result bb p;
             run_game ns
        else run_game (Bsupdater.no_bs cl s)
      else
        if Hbs.call_bs ()
        then let (bb,ns) = Bsupdater.check_bs s cl nc tc 4 in
             Bsprint.hbs_result bb s.cp;
             run_game ns
        else run_game (Bsupdater.no_bs cl s)
    with
    | _ -> false
let rec game_start () =
  if Hbs.start ()
  then run_game Bsupdater.new_game Deck.new_deck ()
  else false

let run bid =
  Bsprint.rules ();
  if game_start ()
  then bid
  else -2 * bid
