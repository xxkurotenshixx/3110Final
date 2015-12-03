module Bjprinter:
sig

  val round_lost: unit -> unit

  val game_tie: unit -> unit

  val round_won: unit -> unit

  val quit: unit -> unit

  val welcome: unit -> unit

  val help: unit -> unit

  val rules: unit -> unit

  val print_hand: Card.card list -> unit

  val start_prompt: unit -> unit

end