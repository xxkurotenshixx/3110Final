open Card

(* [game_lost] prints a message signaling that the player
 * has lost the game. *)
val game_lost: unit -> unit

(* [game_won] prints a message saying that the player has 
 * won the game *)
val game_won: unit -> unit

(* [player_turn player card_number] prints a message telling
 * the player whose turn it is what card to play. *)
val player_turn: int -> int -> unit

(* [cards_played player card_number rank] prints a message 
 * with the card and rank played by the most recent 
 * player*)
val cards_played: int -> int -> Card.rank -> unit

(* [bs_result bool player] prints a message according to 
 * whether or not the person who called Bullshit was 
 * correct. *)
val bs_result: bool -> int -> unit

(* [hbs_result bool player] prints a message saying
* whether or not you were right on calling Bullshit 
* on player. *)
val hbs_result: bool -> int -> unit

(* [quit] prints a message asking if you actually
wanted to quit the game. *)
val quit: unit -> unit

(* [help] prints a message telling you the commands
 * you can print at any point during the game to be 
 * redirected. *)
val help: unit -> unit

(* [rules] prints a message stating all the rules of 
 * Bullshit *)
val rules: unit -> unit

(* [print_hand card_list] prints the list of all the
* cards in your hand. *)
val print_hand: Card.card list -> unit

(* [what_cards curr_card] prints a message telling
 * the player what card is currently to be played. *)
val what_cards: int -> unit

(* [start_prompt] prints the starting prompt. *)
val start_prompt: unit -> unit

(* [bs_prompt] prints a prompt asking the player if
 * they would like to call Bullshit on the current
 * player. *)
val bs_prompt: unit -> unit

(* [hand_format_prompt] prints a message telling the
 * player how to properly type out the hand to be 
 * played. *)
val hand_format_prompt: unit -> unit

(* [welcome] prints a message welcoming the user
 * to the game of Bullshit. *)
val welcome: unit -> unit
