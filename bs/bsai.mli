open Card

(* [call_bsp()] checks each AI to see if bs is called. If one does, then
 * then it returns true and which AI called bullshit. Otherwise it returns
 * false and 0. *)
val call_bsp: unit -> bool*int

(* [play_card i] takes in the current card in int format and uses the AI's
 * algorithm to return a list of cards played, the number of cards played,
 * and the rank of the card. *)
val play_card: int -> Card.card list -> Card.card list*int*Card.rank
