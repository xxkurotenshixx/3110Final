(*neatly organizes the possible inputs main takes*)
type input = Quit | Check | Game of int | Confirm of bool
            | Help | Gibberish | Null

(*takes the player's current score and
  returns a string of the appropiate caml pun
  No money?          -> Dead Caml
  Lost money?        -> Calf
  Same money?        -> Camlflaged
    Gained money?      ->  *Caml
        replace * with a letter corresponding to how much profit you made (from A-N)
  Highest score tier -> OCaml: King of Camllot *)
val points_to_caml: int -> string

(*the method that starts the game.
  more or less a mask for the recurring "run" function*)
val start: unit -> unit

(*the main game loop. Takes an int to represent the current score.
  Returns the final score to "start" when the player quits.*)
val run: int -> int

(*method called by run to parse the input taken from
  the Parser module and return an input type to represent it*)
val parse_input: unit -> input