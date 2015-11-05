
(**
  * [parse] runs the game
  *
  *)
val parse : unit -> bool

(**
  * [game_start]
  *
  *)

val game_start : unit ->

(**
  * [run bet] simulates a round of Bullshit.
  *
  * The player begins with a betted amount. It returns true if the game is won.
  *)
val run : int -> bool


(**
  *
  *
  *)
val quit :

(*false means lose*)