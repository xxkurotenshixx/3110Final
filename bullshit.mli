open Card
open Bsupdater
module Bullshit:
sig
(*  type state =  {p1: Card.card list; p2: Card.card list; p3: Card.card list;
               p4: Card.card list; c: Card.card list; cp: int; cn: int}
 *)
  (**
  * [game_start] acts as the game engine.
  *
  *)

  val game_start : unit -> bool

  (**
   * [run bet] simulates a round of Bullshit.
   *
   * The player begins with a betted amount. It returns the net amount won or lost.
   *)
  val run : int -> int

  val run_game: Bsupdater.state -> bool
end
