module Bjupdater:
sig

  
  val sum: Card.card list -> (bool *  int)

  (*is p a string in hit s p?*)
  val hit: state -> Card.card list -> state

  val new_game_deal: int -> state -> Card.card list

  val new_table: int -> Card.card list

  val money: state -> state

  val deck: state -> state

  val player: state -> state

  val finished: state -> state 

end
