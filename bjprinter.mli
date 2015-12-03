module Bjprinter:
sig
  open Card
  val leave: int -> int -> int -> unit

  val player_prompt: unit -> unit

  val prompt: unit -> unit
  (* [game_lost] prints the message the player sees when they lose the game *)
  val round_lost: unit -> unit

  (* [game_won] prints the message the player sees when they win the game *)
  val round_won: unit -> unit

  val game_tie: unit -> unit


  val quit: unit -> unit

  val welcome: unit -> unit

  val help: unit -> unit

  val rules: unit -> unit

  val print_hand: Card.card list -> unit

  val start_prompt: unit -> unit

  val bid_prompt: unit -> unit
end
