(**
  * [game_start] acts as the game engine.
  *
  *)

val game_start : unit -> bool

(**
  * [run bet] simulates a round of Blackjack.
  *
  * The player begins with a betted amount. It returns the net amount won or lost.
  *)
val run : int -> int


