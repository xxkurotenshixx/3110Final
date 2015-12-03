module Bjupdater = struct
  open Deck
  open Card

  type state = {dealer: Card.card list; player: Card.card list;
                deck: Card.card list; money: int; rounds: int;
                dp:int; pp:int; finished: bool; win:int}

  let sum cl =
    let aceis1 x = match Card.card_to_int x with
      | 11 | 12 | 13 -> 10
      | x -> x in
    let aceis11 x = match Card.card_to_int x with
      | 11 | 12 | 13 -> 10
      | 1 -> 11
      | x -> x in
    let pa1 = List.fold_left (fun p x -> p + aceis1 x) 0 cl in
    let pa11 = List.fold_left (fun p x -> p + aceis11 x) 0 cl in
    if pa11 <= 21 then
      pa11
    else
      pa1

  let winner s =
    if s.dp = s.pp
    then {s with win = 0}
    else if s.pp > s.dp
    then {s with win = 1}
    else {s with win = -1}

  let hit s p =
    let (cd, deck) = Deck.draw s.deck in
    if p = "player"
    then
      let player = cd::s.player in
      winner {s with player; deck; pp = sum player}
    else
      let dealer = cd::s.dealer in
      winner {s with dealer; deck; dp = sum dealer}

  let round_won bid s =
    {s with money = s.money + 3*bid}

  let new_game_deal bid s =
    let deck =
      if List.length s.deck < 10 || rounds mod 5 = 0
      then
        s.deck @ Deck
      else
        s.deck in
    let ns = {s with rounds = s.rounds + 1; money = s.money - bid;
                     deck; dp = 0; pp = 0} in
    let order = ["player";"dealer";"player";"dealer"] in
    List.fold_left hit ns order

  let new_table money =
    let deck = Deck.new_double_deck () in
    new_game_deal {dealer = []; player = []; deck; money; rounds = 0;
                  dp = 0; pp = 0; finished = false; win= 0}

  let money s = s.money
  let deck s = s.deck
  let player s = s.player
  let finished s = s.finished
  let pbust s = s.pp > 21
  let dbust s = s.dp > 21
  let ddraw s = s.dp < 17
  let winner s = s.win
end
