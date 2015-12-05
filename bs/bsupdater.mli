open Card

type state

(* Creates a new game state and deals the cards. *)
val new_game: unit -> state

(* Returns a new list with the cards from the second list removed from
 * the first list. *)
val remove_cards: Card.card list -> Card.card list -> Card.card list

(* Checks if the player lied or not and updates the state accordingly. *)
val check_bs: state -> Card.card list -> int -> Card.rank -> int -> bool*state

(* Updates the state after a player finishes their turn. *)
val no_bs: Card.card list -> state -> state

(* Indicates if the AI won. *)
val ai_win: state -> bool

(* Indicates if the human player won. *)
val p_win: state -> bool

(* Accessor for player hand. *)
val p: state -> int -> Card.card list

(* Accessor for current player. *)
val cp: state -> int

(* Accessor for current card. *)
val cn: state -> int
