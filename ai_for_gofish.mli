(**
 * [ai_turn ai gs] will decide what action [ai] will perform. gs
 * will be mutated based on what action is chosen. If that turn ends the
 * game, returns unit. If the game is still not over, it will call
 * the next player's turn.
 * (The game will eventually end, untimately returning unit.)
 *)
val ai_turn : player -> game_state -> unit
