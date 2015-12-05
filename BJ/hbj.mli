(* Returns if the player decided to start a round. Takes in the money the
 * player currently has.*)
val start: int -> bool

(* Returns how much the player bets. *)
val bid: int -> int

(* Returns true if the player hits, false if the player stands.
 * Throws an exception if the player quits. *)
val play: int -> bool
