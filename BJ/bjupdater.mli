open Card
open Deck

type state
(* Sums the value of the hand. *)
val sum: Card.card list ->  int

(* Updates who currently has a higher valid score. *)
val winner: state -> state

(* Draw a card. *)
val hit: state -> string -> state

(* Deals out the hand for a new game. *)
val new_game_deal: int -> state -> state

(* Creates a new table. *)
val new_table: int -> state

(* Returns the money the player has. *)
val get_wallet: state -> int

(* Returns the deck currently used. *)
val deck: state -> Deck.deck

(* Returns the player's hand. *)
val player: state -> Card.card list

(* Returns the dealer's hand. *)
val dealer: state -> Card.card list

(* If the player busted. *)
val pbust: state -> bool

(* If the dealer busted. *)
val dbust: state -> bool

(* If the dealer should draw. *)
val ddraw: state -> bool

(* If the winner is the player or the dealer. *)
val win: state -> int

(* Returns the number of rounds played. *)
val rounds: state -> int

(* Updates the state to add the money won. *)
val add_win: int -> state -> state
