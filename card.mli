module Card:
sig
  (*used to represent card suits*)
  type suit = Spades | Diamonds | Hearts | Clubs
  (*used to represent card rank*)
  type rank = Two | Three | Four | Five | Six | Seven | Eight | Nine |
              Ten | Jack | Queen | King | Ace
  (*a card represented by a suit and a rank*)
  type card = suit * rank

  (*returns a string representation of the card*)
  val card_to_string: card -> string

  (*takes two cards and returns whether they have the same number*)
  val same_number: card -> card -> bool

  val card_to_int: card -> int

  val int_to_rank: int -> rank

  val string_to_rank: string -> rank

  val rank_string: rank -> string

  val suit_string: suit -> string

  val string_to_card: string -> card

  val int_to_str: int -> string

  val same_card: card -> card -> bool
end
