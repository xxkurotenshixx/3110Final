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

let rules () = Printf.printf "In Bullshit, you are playing against three other players.\n
 You start each game with a hand of cards and the GOAL of the
 game is to PUT DOWN all of your cards. \n
 How, do I do that you may ask? \n
 The first player puts down cards in ascending order, starting with an Ace. \n
 For example, you could put down an Ace and then a Two.
 The next player would then start by putting down a Two and then three Threes
 and a Four. \n
 HOWEVER, what YOU SAY YOU PUT DOWN - notated by the first section of your
 input (AKA Numbers of Cards,Type of Card) - is not necessarily what you
 put down. \n
 The cards YOU ACTUALLY PUT DOWN are notated after in the form
 of Suit,Number. \n
 These are the Suits: Spades, Hearts, Clubs, Diamonds
 The 'Number' is notated in this form: 1 is the Ace, 2 is Two,
 11 is Jack, 12 is Queen, and 13 is King. \n

 You, as well as every other player, can call Bullshit after
 another player's cards are put down. When this happens,
 you either: 1. Are correct and the entire pile is put in the
 losing player's hand OR 2. Are wrong and those cards are put
 into your hand.

 TYPE start to begin.
 TYPE help if you need help at any point during the game.
 TYPE quit if you would like to exit the game.\n"

let print_hand cards =
  let rec helper = function
    |[] -> ()
    |h::t -> Printf.printf "%s\n" (Card.card_to_string h);
             helper t in
  Printf.printf "Cards in your hand: \n";
  helper cards

let what_cards n =
Printf.printf " \nWhat would you like to play? Please enter it in the \
following format: \n
Number of Cards,Type of Card Suit,Number Suit,Number etc.\n
A Suit is Spades, Diamonds, Clubs, or Hearts.
The Number is notated as follows: Ace is 1, Jack is 11, Queen is 12, King is 13
e.g. 3,Ace Spades,1 Diamonds,13 Hearts,4\n

 The current card is: %s.\n
 Please play at least one card.
 To see your cards, enter 'hands'.\n" (Card.int_to_str n)

let starter () =
  Printf.printf "Please enter start, help, or quit.\n"

let bs_prompt () =
  Printf.printf "Please enter y, n, or hands.\n"
end
