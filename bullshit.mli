(**
  * [game_start] acts as the game engine.
  *
  *)

val game_start : unit -> bool

(**
  * [run bet] simulates a round of Bullshit.
  *
  * The player begins with a betted amount. It returns the net amount won or lost.
  *)
val run : int -> int


(*'a list is a list of cards *)
(*[play_card i] takes in the previously played card in int format and returns
a list of a cards*)
val play_card: int -> 'a list



(**
  *
  *)
val quit :
