open Bjupdater

(* Updates the state until the player is done making choices. *)
val player_turn: Bjupdater.state -> Bjupdater.state

(* Updates the state until the dealer is done. *)
val dealer_turn: Bjupdater.state -> Bjupdater.state

(* Checks if the player wants to play again after a loss/tie.*)
val p_lost_tie: Bjupdater.state -> Bjupdater.state

(* Updates the state and checks if the player wants to play again.*)
val d_lost: int -> Bjupdater.state -> Bjupdater.state

(* Returns an updated state with the results of the round. *)
val status: Bjupdater.state -> int -> Bjupdater.state

(* Game Engine that runs multiple rounds of Blackjack. *)
val runner: Bjupdater.state -> Bjupdater.state

(* Takes the money the player started with and returns the money left.*)
val run: int -> int
