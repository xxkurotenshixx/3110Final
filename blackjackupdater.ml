module Blackjackupdater = struct
open Deck
open Card

type state = {dealer: Card.card list; player: Card.card list}

let new_game () =
  let deck = Deck.new_quad_deck () in

let remove_cards h cl =
  List.filter(fun x -> not(List.exists (Card.same_card x) cl)) h



end