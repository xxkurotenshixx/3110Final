module Bjupdater:
sig


  val sum: Card.card list -> int

  val winner: state -> state

  val hit: state -> string -> state

  val round_won: int -> state -> state

  val new_game_deal: int -> state -> Card.card list

  val new_table: int -> Card.card list

  val money: state -> state

  val deck: state -> state

  val player: state -> state

  val finished: state -> state

  val pbust: state -> bool

  val dbust: state -> bool

  val ddraw: state -> bool

  val winner: state -> int

end
