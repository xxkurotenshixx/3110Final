open Card

(* [card val card hand] returns the equivalent numeric value of the card.
 * In the case that the card is an Ace, it looks through the remainder of the
 * hand in order to determine whether or not the value should be 1 or 11.
 * If the remainder of the deck + the given Ace is still less than or equal to 21,
 * the value of the card is 11. Otherwise, the value of the card is 1
 *)
val card_val: Card.card -> Card.card list -> int

(* [sum hand] goes through the list and finds the total sum of the card values*)
val sum: Card.card list -> int

(* [compare_sum h1 h2] determines who wins by checking to see whose hand sums to
 * the larger value
 *)
val compare_sum: Card.card list -> Card.card list -> unit

(* [dealer_move hand] determines what happens when the dealer has a sum of 21,
 *   greater than 17 or less than 17.
 *     If the dealer has a sum of 21, it then checks to see
 *     whether or not the player also has 21. If both have 21, a tie game is
 *     called. If only the dealer has 21, the dealer wins.

 *     If the dealer has greater than 17, he "stands" and the sum of the dealer's
 *     hand is then compared with the sum of the player's hand.
 *
 *     If the dealer has less than 17, he "hits" and gets another card.
*)
val dealer_move: Card.card list -> unit

(* [player_check h1 h2] checks to see if the player has a sum greater than 21,
 *  otherwise known as a bust, a sum of 21, or any other input.

 *   If the sum is greater than 21, the player automatically loses.
 *   If it is a sum of exactly 21, it is now the dealer's move.
 *   In any other scenario, the player's hand is printed.
 *)
val player_check: Card.card list -> Card.card list -> unit


(* [player_move h1] matches against player input.
    If the player types in "hit", then they are given a new hand, the new hand's
    sum is checked to make sure it is not over 21, and then they are given the
    opportunity to hit or stand.

    If the player types in "stand", then it is now the dealer's turn.*)
val player_move: Card.card list -> unit

val hit: Card.card list -> unit ??

