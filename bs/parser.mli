(* [parse] reads the user input and returns a list of lowercase strings
 *  split according to the spaces found in the input. Returned list is
 *  guaranteed to have a length greater than 0 and strings of length 1
 *  or greater. *)
val parse : unit -> string list

(* [confirm] reads the user input and returns true if the user confirms
 * their coice and false otherwise. *)
val confirm: unit -> bool
