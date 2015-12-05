open Card

let game_lost () =
  Printf.printf " Game over! Another player has played all
                 of their cards before you. \n"

let game_won () =
  Printf.printf " Congratulations! You WIN!"

let player_turn p n =
  Printf.printf " It is Player %i's turn! Please play a %s.\n"
                p (int_to_str n)

let cards_played p nc tc =
  Printf.printf " Player %i has played %i %s(s). Bullshit? (y/n)\n"
                p nc (rank_string tc)

let bs_result b p =
  if b
  then
    Printf.printf " BULLSHIT! Player %i has called you out!\n\
                    The pile has been added to your hand.\n" p
  else
    Printf.printf " Player %i called BS, but it wasn't meant to be.\n\
                    The pile has been added to Player %i's hand.\n" p p

let hbs_result b p =
  if b
  then
    Printf.printf " You got it! Player %i was lying.\n\
                    The pile has been added to Player %i's hand.\n" p p
  else
    Printf.printf " Sorry! But Player %i was telling the truth.\n\
                    The pile has been added to your hand.\n" p

let quit () =
  Printf.printf " Are you sure you wish to leave? \
                 You will lose your bet. (y/n)\n"

let help () =
  let message =
    " You can use these commands at any point in the game:\n" ^
    " 1. help: Prints a list of commands you can use.\n" ^
    " 2. rules: Prints the rules of the game.\n" ^
    " 3. quit: Express your desire to leave.\n" ^
    " 4. hand: Displays your hand (only available after you\n" ^
    "    have started a game and it's your turn.)\n" ^
    " 5. asd: Prints a prompt of what you need to do.\n" ^
    " ** REMINDER: After you type quit, you must answer\n" ^
    "    yes(y) or no(n). The system will not be able to respond\n" ^
    "    to any other command until you do.**\n" in
  Printf.printf "%s" message

let rules () =
  let message =
    " The rules of Bullshit are:\n" ^
    " 1. The player with the Ace of Spades will start.\n" ^
    " 2. Each player must play at least one card.\n" ^
    " 3. Each player must state what how many cards they play\n" ^
    "    and the type of card. The number of cards played must\n" ^
    "    match up, and the type of card must match with the\n" ^
    "    required one, otherwise if another player calls bullshit\n" ^
    "    even if the cards match up with what the player said, it\n" ^
    "    will still be considered a lie.\n" ^
    " 4. The card required will go increment from Ace to King before\n" ^
    "    looping around once again.\n" ^
    " 5. You may call bullshit if you feel the player lied, but be\n" ^
    "    warned that if the player did not lie, the pile will be\n" ^
    "    added to your hand.\n" ^
    " 6. The first player to empty their hand wins the game.\n" in
  Printf.printf "%s" message

let print_hand cards =
  let rec helper = function
    |[] -> ()
    |h::t -> Printf.printf "  %s\n" (card_to_string h);
             helper t in
  Printf.printf " Cards in your hand: \n";
  helper cards

let what_cards n =
  Printf.printf " What would you like to play?\n\
                  The current card is: %s.\n\
                  Please play at least one card.\n\
                  To see your cards, enter 'hand'.\n" (int_to_str n)

let start_prompt () =
  Printf.printf " Please enter start, help, rules, or quit.\n"

let bs_prompt () =
  Printf.printf " Please enter yes(y), no(n), help, rules, hand, or quit.\n"

let hand_format_prompt () =
  let message =
    " Please enter it in the following format:\n" ^
    " # Cards, Type of Card     Suit,Number  Suit,Number  ...\n" ^
    " Where a Suit is: Spades, Diamonds, Clubs or Hearts\n" ^
    " Ace is 1, Jack is 11, Queen is 12, and King is 13\n" ^
    " e.g. 3,Ace   Spades,1  Diamonds,13  Hearts,4 \n" in
  Printf.printf "%s" message

let welcome () =
  let message =
    " Welcome to the table. Below are the rules and commands that\n"^
    " apply to bullshit. We hope you enjoy your time here!\n" in
  Printf.printf "%s" message
