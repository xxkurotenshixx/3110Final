open Card

(*represents a stack of several cards*)
type deck

(*thrown when atempting to draw from an empty deck*)
exception Empty

(* [combine_deck d1 d2] takes 2 decks and combines the
 * two of them. *)
val combine_deck: deck -> deck -> deck

(*the empty deck*)
val empty: deck

(*[new_deck] returns the ordered, standard 52 card deck. *)
val new_deck: unit -> deck

(* [new_double_deck] returns an ordered deck made of two standard
 * 52 card decks. *)
val new_double_deck: unit -> deck

(* [new_quad_deck] returns an ordered deck made of four standard
 * 52 card decks*)
val new_quad_deck: unit -> deck

(* [draw deck card] picks a card randomly from the deck and
 * returns the card paired with the deck with that card removed
 * Raises Empty if there are no cards in the deck *)
val draw: deck -> Card.card * deck

(* [size deck] returns the size of the list of cards. *)
val size: deck -> int
