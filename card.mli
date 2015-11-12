module Card = sig
  (*used to represent card suits*)
  type suit = Hearts | Diamonds | Spades | Clubs
  (*a card represented by a suit and a number
    1 -> A, 11 -> J, 12 -> Q, 13 -> K        *)
  type card = suit * int

  (*returns a string representation of the card*)
  val card_to_string: card -> string

  (*takes two cards and returns whether they have the same number*)
  val same_number: card -> card -> bool
end