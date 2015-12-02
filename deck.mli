open Card
module Deck:
sig
  (*represents a stack of several cards*)
  type deck

  (*thrown when atempting to draw from an empty deck*)
  exception Empty

  (*the empty deck*)
  val empty: deck

  (*The ordered, standard 52 card deck*)
  val new_deck: deck

  (*An ordered deck made of two standard 52 card decks*)
  val new_double_deck: deck

  (*picks a card randomly from the deck
  returns the card paired with the deck with that card removed
  Raises Empty if there are no cards in the deck *)
  val draw: deck -> Card.card * deck

  (*returns the size of the list of cards*)
  val size: deck -> int
end
