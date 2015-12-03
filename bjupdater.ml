module Bjupdater = struct
  open Deck
  open Card

  type state = {dealer: Card.card list; player: Card.card list;
                deck: Card.card list; money: int; rounds: int;
                dp:bool*int; pp:bool*int ;finished: bool}

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
      (false,pa11)
    else
      (true,pa1)

  let hit s p =
    let (cd, deck) = Deck.draw s.deck in
    if p = "player"
    then
      let player = cd::s.player in
      {s with player; deck
    else
      let dealer = cd::s.dealer in
      {s with dealer; deck; dp = (fst s.dp, add_val (snd s.dp) cd)}


       let new_game_deal bid s =
    let deck =
      if List.length s.deck < 10 || rounds mod 5 = 0
      then
        s.deck @ Deck
      else
        s.deck in
    let ns = {s with rounds = s.rounds + 1; money = s.money - bid;
                     deck; dp = false*0; pp = false*0} in
    let order = ["player";"dealer";"player";"dealer"] in
    List.fold_left hit ns order

  let new_table money =
    let deck = Deck.new_double_deck () in
    new_game_deal {dealer = []; player = []; deck; money; rounds = 0;
                  dp = false*0; pp = false*0; finished = false}

  let money s = s.money
  let deck s = s.deck
  let player s = s.player
  let finished s = s.finished



end
