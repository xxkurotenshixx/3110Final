open Card
module Bsupdater:
sig
  type state
  val new_game: unit -> state

  val remove_cards: Card.card list -> Card.card list -> Card.card list

  val check_bs: state -> Card.card list -> int -> Card.rank -> int -> bool*state

  val no_bs: Card.card list -> state -> state

  val ai_win: state -> bool
  val p_win: state -> bool

  val p: state -> int -> Card.card list
  val cp: state -> int
  val cn: state -> int

end
