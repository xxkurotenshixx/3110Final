

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
val run : int -> int

(**
  * [decision]
  *)

val decision: unit -> bool

(*'a list is a list of cards *)
(*[play_card i] takes in the previously played card in int format and returns
a list of a cards*)
val play_card: int -> 'a list



(**
  *
  *
  *)
val quit :

(*false means lose*)