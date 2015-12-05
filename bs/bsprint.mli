open Card

val game_lost: unit -> unit
val game_won: unit -> unit
val player_turn: int -> int -> unit
val cards_played: int -> int -> Card.rank -> unit
val bs_result: bool -> int -> unit
val hbs_result: bool -> int -> unit
val quit: unit -> unit
val help: unit -> unit
val rules: unit -> unit
val print_hand: Card.card list -> unit
val what_cards: int -> unit
val start_prompt: unit -> unit
val bs_prompt: unit -> unit
val hand_format_prompt: unit -> unit
val welcome: unit -> unit