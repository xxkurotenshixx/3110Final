(**
 * players are the 4 possible player in a game of go fish: Human, and the
 * three AIs
 *)
type player

(**
 * game_state holds all the valuable information about the current state
 * of the go fish game.
 *)
type game_state

(**
  * [run bet] simulates a game of Go Fish.
  *
  * It returns the net amount won or lost. Magnitude of return is
  * proportional to magnitude of bet.
  *)
val run : int -> int
