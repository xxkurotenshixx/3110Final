(**
 * [choose_random hand] will return a random card in hand
 *)
val choose_random : Card.card list -> Card.rank


(**
 * [ai_decide hand choices] will return the most reasonable rank to ask for
 *)
val ai_decide : Card.card list -> Card.rank list -> Card.rank option
