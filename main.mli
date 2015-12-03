module Main:
sig
  (*neatly organizes the possible inputs main takes*)
  type input = Number of int | Quit | Check | Game of int | Confirm of bool | Help | Gibberish

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

  (*the main game loop. Takes an int to represent the current score*)
  val run: int -> unit

  (*method called by run to parse the input taken from
    the Parser moduel and return an input type to represent it*)
  val parse_input: unit -> input

  (*responds to the input apropriately.
    is given the current score in a pair for
    printing the current score if necssary*)
  val respond: (input * int) -> int
end