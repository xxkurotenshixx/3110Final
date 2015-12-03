open Card

module Blackjackprint = struct
let round_lost () =
  Printf.printf "Game over! The dealer was closer to 21 than you were!\n\
                 Would you like to play again?"

let game_tie () =
  Printf.printf "Both you and the dealer have the same amount.\n"

let round_won () =
  Printf.printf "Congratulations! You WIN! Would you like to play again?"

let quit () =
  Printf.printf "Are you sure you wish to leave? \
                 You will lose your bet. (y/n)\n"

let welcome () = Printf.printf "WELCOME TO A GAME OF BLACKJACK!"


let help () = "unimplemented"

let rules () = Printf.printf "So you want to play a game of Blackjack? \
In Blackjack, the rules are simple: get 21 or get closer to 21 than the
dealer. The dealer is your only opponent.

The game starts with you, the player, receiving two cards. The dealer also
receives two cards; however, you can only see the first.

Each card has a value, with the numbered cards having the value given, the
face cards (King, Queen, and Jack) having values of 10 a piece, and finally
the Ace. The Ace can either have a value of 1 or 11.

The player can choose to type 'hit' or 'stand' after seeing the given cards.
To 'hit' means to add another card to your hand. To 'stand' means to finish
your turn. Once you type 'stand', it becomes the dealer's turn. When the
dealer finishes, cards are compared and the number closest to 21 wins!
"

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
