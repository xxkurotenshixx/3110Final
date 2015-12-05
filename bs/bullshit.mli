open Card
open Bsupdater

(* [game_start] checks if the player has started the game.
 * If the player has, run_game is called. game_start then
 * returns if the player won or lost the game. *)
val game_start : unit -> bool

(* [run bet] returns the net amound won or lost. *)
val run : int -> int

(* [run_game s] acts as the game_engine. *)
val run_game: Bsupdater.state -> bool
