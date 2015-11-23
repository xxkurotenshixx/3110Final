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
