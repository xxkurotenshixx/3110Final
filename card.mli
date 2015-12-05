(*used to represent card suits*)
type suit = Spades | Diamonds | Hearts | Clubs
(*used to represent card rank*)
type rank = Two | Three | Four | Five | Six | Seven | Eight | Nine |
            Ten | Jack | Queen | King | Ace
(*a card represented by a suit and a rank*)
type card = suit * rank

(* [card_to_string card] returns a string representation of the card *)
val card_to_string: card -> string

(* [same_number card1 card 2] takes two cards and returns whether they 
 * have the same number. *)
val same_number: card -> card -> bool

(* [card_to_int card] returns the int representation of the card. *)
val card_to_int: card -> int

(* [int_to_rank n] returns the rank corresponding to the number n. *)
val int_to_rank: int -> rank

(* [string_to_rank s] returns the rank corresponding to the string s. *)
val string_to_rank: string -> rank

(* [rank_string rank] converts rank to the corresponding string. *)
val rank_string: rank -> string

(* [suit_string suit] converts the suit to the corresponding string. *)
val suit_string: suit -> string

(* [string_to_card s] converts the string s to the corresponding card. *)
val string_to_card: string -> card

(* [string_to_suit s] converts the string s to the corresponding suit. *)
val string_to_suit: string -> suit

(* [int_to_str n] converts the number n to a string. *)
val int_to_str: int -> string

(* [same_card card1 card2] checks to see whether or not card1 and card2 
 * have both the same suit and rank. *)
val same_card: card -> card -> bool
