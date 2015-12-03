module Bjupdater:
sig
  open Card
  open Deck

  type state
  val sum: Card.card list ->  int

  (*is p a string in hit s p?*)
  val hit: state -> string -> state

  val new_game_deal: int -> state -> state

  val new_table: int -> state

  val money: state -> int

  val deck: state -> Deck.deck

  val player: state -> Card.card list

  val finished: state -> bool

  val pbust: state -> bool

  val dbust: state -> bool

  val ddraw: state -> bool

  val winner: state -> int

  val rounds: state -> int

  val round_won: int -> state -> state
end
