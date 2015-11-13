(**
 * players are the 4 possible player in a game of go fish: Human, and the
 * three AIs
 *)
type player = H | AI1 | AI2 | AI3

(**
 * game_state holds all the valuable information about the current state
 * of the go fish game.
 *)
type game_state =
  {mutable h_books : int; mutable ai1_books : int; mutable ai2_books : int;
   mutable ai3_books : int; mutable h_hand : Card.t list;
   mutable ai1_hand : Card.t list; mutable ai2_hand : Card.t list;
   mutable ai3_hand : Card.t list; mutable history : (Card.t * player) list;
   mutable deck : Deck.t}

(**
 * h_turn will prompt the user to take a turn. game_state will be mutated
 * based on what action the user did. If that turn ends the game, returns
 * unit. If the game is still not over, it will call the next player's turn.
 * (The game will eventually end, untimately returning unit.)
 *)
val h_turn : game_state -> unit

(**
  * [run bet] simulates a game of Go Fish.
  *
  * It returns the net amount won or lost. Magnitude of return is
  * proportional to magnitude of bet.
  *)
val run : int -> int

