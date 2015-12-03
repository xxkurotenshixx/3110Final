open Card
module Bsupdater:
sig
  type state
  
  (* [new_game ()] finds the player with the Ace of Spades card, appends 
   * that card to their hand and has that player start the game.*)
  val new_game: unit -> state

  (* [remove_cards hand cl] returns the new hand without the list 
   *  of cards cl. *)
  val remove_cards: Card.card list -> Card.card list -> Card.card list

  (* [check_bs state card_list num rank player_number] goes through
   *  the player's card_list to check to see if the opposing player
   *  was correct in calling BS. *)
  val check_bs: state -> Card.card list -> int -> Card.rank -> int -> bool*state

  (* [no_bs cl st] has the game continue if no 'Bullshit' is called.*)
  val no_bs: Card.card list -> state -> state

  (* [ai_win st] determines when the ai_wins - when the player has cards 
   * remaining, but one of the three ai's has finished their hand.*) 
  val ai_win: state -> bool
  
  (* [p_win st] determines when the player wins - when the player 
   * has no cards remaining in their hand.*)
  val p_win: state -> bool
  (* [p st n] matches the number with the correct player*)
  val p: state -> int -> Card.card list
  
  (* [cp st] returns the number of the current player.*)
  val cp: state -> int
  (* [cn st] returns the current number of rounds. *)
  val cn: state -> int

end
