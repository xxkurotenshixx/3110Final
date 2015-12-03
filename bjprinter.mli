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

  (* [quit]  prints a message if the user types in 'quit,' asking whether or not
   * they actuallt want to quit the game *)
  val quit: unit -> unit

  (* [welcome] prints the welcome screen when the player enters a game of
   * Blackjack*)
  val welcome: unit -> unit

  (* *)
  val help: unit -> unit

  (* [rules] prints a message containing the rules for the game.  *)
  val rules: unit -> unit

  (* [print_hand cl] prints the cards in the player's hand.*)
  val print_hand: Card.card list -> unit

  (* [start_prompt] prints the starting message. *)
  val start_prompt: unit -> unit

  val bid_prompt: unit -> unit
end
