open Card

(* Returns if the player decided to start a game. *)
val start: unit -> bool

(* Returns a list of cards the player has played. Throws an exception
 * if the player quits the game. *)
val play_cards: int -> Card.card list -> Card.card list*int*Card.rank

(* Returns if the player decided to call bullshit. Throws an exception
 * if the player quits the game. *)
val call_bs: Card.card list -> bool
