open Card

module Blackjackprint = struct
let natural_lost () =
  Printf.printf "Game over! The dealer had a natural 21. \n"

let game_lost () =
  Printf.printf "Game over! The dealer was closer to 21 than you were!\n"

let game_tie () =
  Printf.printf "Both you and the dealer have the same amount.\n"

let game_won () =
  Printf.printf "Congratulations! You WIN!"

let quit () =   Printf.printf "Are you sure you wish to leave? \
               You will lose your bet. (y/n)\n"

let welcome () = "unimplemented"


let help () = "unimplemented"

let rules () = "unimplemented"

let print_hand cards =
  let rec helper = function
    |[] -> ()
    |h::t -> Printf.printf "%s\n" (Card.card_to_string h);
             helper t in
  Printf.printf "Cards in your hand: \n";
  helper cards

let start_prompt () =
  Printf.printf "Please enter start, help, or quit \n"




end