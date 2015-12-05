open Card

(*represents a stack of several cards*)
type deck

(*thrown when atempting to draw from an empty deck*)
exception Empty

val combine_deck: deck -> deck -> deck

(*the empty deck*)
val empty: deck

(*The ordered, standard 52 card deck*)
val new_deck: unit -> deck

(*An ordered deck made of two standard 52 card decks*)
val new_double_deck: unit -> deck

(*An ordered deck made of four standard 52 card decks*)
val new_quad_deck: unit -> deck

(*picks a card randomly from the deck
  returns the card paired with the deck with that card removed
  Raises Empty if there are no cards in the deck *)
val draw: deck -> Card.card * deck

(*returns the size of the list of cards*)
val size: deck -> int
