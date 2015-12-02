open Card
open Deck
module Bsupdater:
sig
  type state = {p1: Card.card list; p2: Card.card list; p3: Card.card list;
                p4: Card.card list; c: Card.card list; cp: int; cn: int}
  val new_game: Deck.deck -> state

  val remove_card: Card.card list -> Card.card list -> Card.card list

  val check_bs: state -> Card.card list -> int -> Card.rank -> int -> bool*state

  val no_bs: Card.card list -> state -> state
end
