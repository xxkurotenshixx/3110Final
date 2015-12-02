open Card
module Bsprint = struct
let game_lost () =
  Printf.printf "Game over! Another player has played all \
                 of their cards before you. \n"

let game_won () =
  Printf.printf "Congratulations! You WIN!"

let player_turn p n =
  Printf.printf "It is Player %i's turn! Please play a %s.\n"
                p (Card.int_to_str n)

let cards_played p nc tc =
  Printf.printf "Player %i has played %i %s(s). Bullshit? (y/n)\n"
                p nc (Card.rank_string tc)

let bs_result b p =
  if b
  then
    Printf.printf "BULLSHIT! Player %i has called you out!\n\
                   The pile has been added to your hand.\n" p
  else
    Printf.printf "Player %i called BS, but it wasn't meant to be.\n\
                   The pile has been added to Player %i's hand.\n" p p

let hbs_result b p =
  if b
  then
    Printf.printf "You got it! Player %i was lying.\n\
                   The pile has been added to Player %i's hand.\n" p p
  else
    Printf.printf "Sorry! But Player %i was telling the truth.\n\
                   The pile has been added to your hand.\n" p

let quit () =
  Printf.printf "Are you sure you wish to leave? \
                 You will lose your bet. (y/n)\n"

let help () =
  Printf.printf "help unimplemented\n"

let rules () = Printf.printf "rules umimplemented\n"

let print_hand cards =
  let rec helper = function
    |[] -> ()
    |h::t -> Printf.printf "%s" (Card.card_to_string h);
             helper t in
  Printf.printf "Cards in your hand: \n";
  helper cards

let what_cards n =
  Printf.printf "What would you like to play? Please enter it in the \
                 following format:\n\\
                 (Number of Cards, Type of Card) (Suit, Number) \
                 (Suit, Number), etc.\n \
                 where a Suit is Spades, Diamonds, Clubs, or Hearts and\n\
                 Ace is 1, Jack is 11, Queen is 12, and King is 13\n
                 e.g. (3, Ace) (Spades, 1) (Diamonds, 13), (Hearts, 4)\n\
                 The current card is: %s.\n\
                 Please play at least one card.\n\
                 To see your cards, enter 'hands'.\n" (Card.int_to_str n)

let starter () =
  Printf.printf "Please enter start, help, or quit.\n"

let bs_prompt () =
  Printf.printf "Please enter y, n, or hands.\n"
end
