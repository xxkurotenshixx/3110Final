open Card
module Bsai:
sig
  (**
   * [bullshit_caller] decides whether the AI will call bullshit.
   *)

  val call_bs: unit -> bool

  val call_bsp: unit -> bool*int

  (*[play_card i] takes in the previously played card in int format and the AI then
  decides which card(s) to play next
   *)

  val play_card: int -> Card.card list -> Card.card list*int*Card.rank
end
