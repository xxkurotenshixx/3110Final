open Card
module Bsprint:
sig
  (* [game_lost ()] prints the message the player sees when they
   * lose the game 
   *)
  val game_lost: unit -> unit
  
  (* [game_won ()] prints the message the player see when they
   * win the game 
   *)
  val game_won: unit -> unit
  
  (* [player_turn player_number next_card] prints the overall 
   * message saying which player's turn it is and what
   * card to play during this turn 
   *)
  val player_turn: int -> int -> unit
  
  (* [cards_played player_number number_of_cards card_type] 
   * prints a message to the player saying the number of
   * cards a player has played and the type of card.
   * It also prints a message asking whether or not the 
   * player wants to call Bullshit 
   *)
  val cards_played: int -> int -> Card.rank -> unit
  
  (* [bs_result b player_num] is called if Bullshit is 
   * called. It then prints a message saying which 
   * player has called Bullshit and whether or not
   * they were correct in their call. 
   *)
  val bs_result: bool -> int -> unit
  
  (* [hbs_result b player_num] is called when you call
   * Bullshit on another player. A message is printed
   * saying whether or not you were correct in your call.
   *)
  val hbs_result: bool -> int -> unit
  
  (* [quit ()] prints a message if the user types in 
   * 'quit,' asking whether or not they actually 
   *  want to quit 
   *)
  val quit: unit -> unit
  
  (* *)
  val help: unit -> unit
  
  (* [rules ()] prints a message containing the 
   * rules for the game when the user types in 
   * 'rules' 
   *)
  val rules: unit -> unit
  
  (* [print_hand cl] prints the cards in the 
   * player's hand 
   *)
  val print_hand: Card.card list -> unit
  
  (* [what_cards num] prints a message telling the player
   * how to format their input when playing cards.
   *)
  val what_cards: int -> unit
  
  (* [starter ()] prints the starting message. *)
  val starter: unit -> unit
  
  (* [bs_prompt ()] prints the prompt asking the player whether 
   *or not they would like to call BS. *)
  val bs_prompt: unit -> unit
end
