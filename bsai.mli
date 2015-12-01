(**
  * [bullshit_caller] decides whether the AI will call bullshit.
  *)

val bullshit_caller: unit -> bool


(*[play_card i] takes in the previously played card in int format and the AI then
  decides which card(s) to play next
*)

val play_card: int -> card list -> card list
