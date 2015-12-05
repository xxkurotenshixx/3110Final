open Deck
open Card

type state = {dealer: Card.card list; player: Card.card list;
              deck: Deck.deck; money: int; rounds: int;
              dp:int; pp:int; win:int}

let get_wallet s = s.money
let deck s = s.deck
let player s = s.player
let dealer s = s.dealer
let pbust s = s.pp > 21
let dbust s = s.dp > 21
let ddraw s = s.dp < 17
let win s = s.win
let rounds s = s.rounds

let sum cl =
  let aceis1 x = match card_to_int x with
    | 11 | 12 | 13 -> 10
    | x -> x in
  let aceis11 x = match card_to_int x with
    | 11 | 12 | 13 -> 10
    | 1 -> 11
    | x -> x in
  let pa1 = List.fold_left (fun p x -> p + aceis1 x) 0 cl in
  let pa11 = List.fold_left (fun p x -> p + aceis11 x) 0 cl in
  if pa11 <= 21 then pa11
  else pa1

let winner s =
  let natural cl= List.length cl = 2 && sum cl = 21 in
  if (s.pp > 21 && s.dp > 21) || (s.dp = s.pp) ||
       (natural s.dealer && natural s.player)
  then {s with win = 0}
  else if s.pp > 21 && s.dp <= 21 || natural s.dealer || s.dp > s.pp
  then {s with win = -1}
  else {s with win = 1}

let hit s p =
  let (cd, deck) = draw s.deck in
  if p = "player"
  then
    let player = cd::s.player in
    winner {s with player; deck; pp = sum player}
  else
    let dealer = s.dealer @[cd] in
    winner {s with dealer; deck; dp = sum dealer}

let add_win bid s =
  {s with money = s.money + 3*bid}

let new_game_deal bid s =
  let deck =
    if size s.deck < 10 || s.rounds mod 5 = 0
    then combine_deck s.deck (new_deck ())
    else s.deck in
  let ns = {rounds = s.rounds + 1; money = s.money - bid; deck;
            dp = 0; pp = 0; dealer = []; player = []; win = 0} in
  let order = ["player";"dealer";"player";"dealer"] in
  List.fold_left hit ns order

let new_table money =
  let deck = new_double_deck () in
  {dealer = []; player = []; deck; money; rounds = 0;
   dp = 0; pp = 0;  win = 0}
