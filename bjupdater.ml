module Bjupdater = struct
  open Deck
  open Card

  type state = {dealer: Card.card list; player: Card.card list;
                deck: Card.card list; money: int; rounds: int}

  let new_game_deal s =
    let deck =
      if List.length s.deck < 10 || rounds mod 5 = 0
      then
        s.deck @ Deck
      else
        s.deck in
    let (cd, d1) = Deck.draw deck in
    let (cd1, d2) = Deck.draw d1 in
    let (cd2, d3) = Deck.draw d2 in
    let (cd3, d) = Deck.draw d3 in
    {s with dealer = [cd,cd2]; player = [cd1;cd3];
            deck = d; rounds = s.rounds + 1}

  let new_table money =
    let deck = Deck.new_double_deck () in
    new_game_deal {dealer = []; player = []; deck; money; rounds = 0}

  let money s = s.money
  let deck s = s.deck
  let player s = s.player



end
