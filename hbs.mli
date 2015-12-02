module Hbs:
sig
  open Card
  val quit_confirm: unit -> bool
  val start: unit -> bool
  val play_cards: int -> Card.card list -> Card.card list*int*Card.rank
  val call_bs: Card.card list -> bool
end
