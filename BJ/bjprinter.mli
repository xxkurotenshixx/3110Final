open Card
(* Prints how much the player started and ends with and how many
 * rounds they played. *)
val leave: int -> int -> int -> unit

(* Prompts the player to stand or hit. *)
val player_prompt: unit -> unit

(* Warns that money is not enough and player is getting kicked out. *)
val not_enuf_mon: unit -> unit

(* Prints the message the player sees when they lose the round *)
val round_lost: unit -> unit

(* Prints the message the player sees when they win the round *)
val round_won: unit -> unit

(* Prints the message shown if the round is a tie. *)
val game_tie: unit -> unit

(* Prints the question confirming if the player wants to leave. *)
val quit: unit -> unit

(* Prints the welcome message and the min and max bets at the table. *)
val welcome: unit -> unit

(* Prints commands that can be used throughout the game. *)
val help: unit -> unit

(* Prints the rules of blackjack. *)
val rules: unit -> unit

(* Prints the string and hand passed in *)
val print_hand: Card.card list -> string -> unit

(* Prompt with commands the user can use before a game starts. *)
val start_prompt: unit -> unit

(* Prompts the player to enter a valid bet. *)
val bid_prompt: unit -> unit

(* Prints how much the player has. *)
val wallet: int -> unit
