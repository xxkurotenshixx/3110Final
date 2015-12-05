open Card

(* [start] returns if the player decided to start a game. *)
val start: unit -> bool

(* [play_cards i cl] returns a list of cards the player has played. 
 * Throws an exception if the player quits the game. *)
val play_cards: int -> Card.card list -> Card.card list*int*Card.rank

(* [call_bs cl] returns if the player decided to call bullshit. 
 * Throws an exception if the player quits the game. *)
val call_bs: Card.card list -> bool
