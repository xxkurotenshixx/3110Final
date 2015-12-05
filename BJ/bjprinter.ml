open Card

let print_hand cards message=
    let rec helper = function
      |[] -> ()
      |h::t -> Printf.printf " %s\n" (card_to_string h);
               helper t in
    Printf.printf "%s" message;
    helper cards

let player_prompt () =
  Printf.printf " It is your turn! Would you like to stand or hit?:\n"

let round_lost () =
  Printf.printf " Game over! The dealer was closer to 21 than you were!\n";
  Printf.printf " Would you like to play again?\n"

let game_tie () =
  Printf.printf " It's a tie. Would you like to play again?\n"

let round_won () =
  Printf.printf " Congratulations! You WIN! Would you like to play again?\n"


let quit () =
  Printf.printf "Are you sure you wish to leave? \
                 You will lose your bet. (y/n)\n"

let welcome () =
  Printf.printf " Welcome to BlackJack. Enjory your time here, but \
                 be warned that if you\n lose all of your money, you \
                 will be kicked out. The minimum bid is 50 \n and the \
                 maximum bid is 500.\n"

let help () =
  let message =
    " Commands that can be used in the game:\n" ^
    " help: Print the commands that can be used.\n" ^
    " rules: Print the rules of blackjack.\n" ^
    " quit: Leave the table.\n" ^
    " money: Check how much you have.\n" ^
    " asd: Print a prompt showing what commands you can use.\n" ^
    " **REMINDER: After you type quit, you must enter yes(y) or no(n)\n" ^
    " first, as the system will no respond otherwise.\n" in
  Printf.printf "%s" message

let rules () =
  let message =
    " So you want to play a game of Blackjack? \n" ^
    " In Blackjack, the rules are simple:\n" ^
    " Get 21 or get closer to 21 than the dealer.\n" ^
    " The dealer is your only opponent.\n" ^
    " The game starts with you, the player, receiving two cards.\n" ^
    " The dealer also receives two cards; only the first is visible to you.\n" ^
    " Each card has a value, with the numbered cards have the value given,\n" ^
    " the face cards (King, Queen, and Jack) have values of 10 a piece, and\n" ^
    " finally the Ace. The Ace can either have a value of 1 or 11.\n\n" ^
    " You can type 'hit' or stand' after seeing your hand.\n" ^
    " To 'hit' means to draw another card. To 'stand' means to finish your\n" ^
    " turn. Once you type 'stand', it is the dealer's turn. When the dealer\n" ^
    " finishes, cards are compared and the number closest to 21 wins!\n\n" ^
    " Be warned though, if at any point during your turn, you bust, the\n" ^
    " dealer wins automatically. Also, if the dealer has a natural hand\n" ^
    " then you will lose unless you also have a natural hand.\n" in
  Printf.printf "%s" message

let print_hand cards message=
    let rec helper = function
      |[] -> ()
      |h::t -> Printf.printf "%s\n" (card_to_string h);
               helper t in
    Printf.printf "%s" message;
    helper cards

let start_prompt () =
  Printf.printf " Please enter start, help, rules, money, or quit \n"

let bid_prompt () =
  let message =
    " Please enter a valid bet. It must be a whole number between 50 \n" ^
    " and the amount you currently have. You can see how much you have\n" ^
    " by entering 'money'\n" in
  Printf.printf "%s" message

let wallet m =
  Printf.printf " You currently have %i points.\n" m

let leave money money_left rounds =
  Printf.printf " You came in with %i points and after %i rounds, \
                 you have %i points.\n" money rounds money_left

let not_enuf_mon () =
  Printf.printf " Sorry, but you don't have enough to play BlackJack anymore.\n\
                 \ Please return to the main lobby.\n"
