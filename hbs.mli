module Hbs:
sig
  open Card
  (* [quit_confirm ()] checks the user input to see if they really
   * meant to quit.
   *)
  val quit_confirm: unit -> bool
  
  (* [start ()] matches on the user input. Three potential results 
   * are start, in which case true is returned, quit, in which 
   * quit_confirm is called, and help, in which help is called.
   *)
  val start: unit -> bool
  
  (* [play_cards num hands] checks the user's input to see if it is 
   * a card that is available in their hand to play as well as if
   *  it is in a parseable format to begin with.
   *)
  val play_cards: int -> Card.card list -> Card.card list*int*Card.rank
  
  (* [call_bs hand] matches user input after the Bullshit prompt is shown. *)
  val call_bs: Card.card list -> bool
end
