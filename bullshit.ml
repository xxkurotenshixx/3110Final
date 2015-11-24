let rec game_start () =
  let input = Parser.parse() in
  if List.length input = 1
  then
    match String.lowercase (List.nth input 0) with
    |"start" -> let deck = Deck.new_deck() in
                let helper n hands pd = match n with
                  |0 -> hands
                  |_ -> let (c, d) = Deck.draw pd in
                        let new_hands =
                          (match n mod 4 with
                           |0 -> [c :: (List.nth hands 0);
                                  List.nth hands 1; List.nth hands 2; List.nth hands 3]
                           |1 -> [List.nth hands 0;
                                  c :: (List.nth hands 1);
                                  List.nth hands 2; List.nth hands 3]
                           |2 ->[List.nth hands 0; List.nth hands 1;
                                 c :: (List.nth hands 2); List.nth hands 3]
                           |_ ->[List.nth hands 0; List.nth hands 1; List.nth hands 2;
                                 c :: (List.nth hands 3)])
                        in helper (n-1) new_hands d
                in let h = helper 52 [[];[];[];[]] deck
                   in game_on (List.nth hands 0) (List.nth hands 1)
                              (List.nth hands 2) (List.nth hands 3) [] 0 1
    |"quit" -> false
    |_ -> Printf.printf "Please enter START or Quit";
          game_start()
  else
    let _ = Printf.printf "Please enter START or Quit" in
    game_start()

let rec game_on p1 p2 p3 p4 center n c =
  let input = Parser.parse () in

  ()

let run bet =
  Printf.printf "You have joined a new round of Bullshit! You have bet %d!" bet;
  Printf.printf "\nYou will be dealt a hand of 13 cards. Your goal\n\
                 is to play all of the cards in your hand before any of the \n\
                 other players do. If you fail, you will lose your bet. If you \n\
                 win you will win twice the amount you bet.\n\
                 Rules:\n\
                 1. The player with the Ace of Spades will start. The player \n\
                 should lay a card or several down in the center face down and \n\
                 should tell the other players what the type of card was and \n\\
                 many were played.
                 2. Players should continue in a clockwise order in consecutive \n\
                 asending order.\
                 3. If you do not have any of the required cards, you may lie \n\
                 and place down other cards. However, if another player calls\n\
                 Bullshit!, and the card(s) turn out not to be the ones you\n\
                 called, you will add the entire center pile to your hand.\n\
                 4. You may also call 'Bullshit' if you believe another \n\
                 player to be lying.\n\
                 5. The first player to play all their cards wins!\n\\
                 6. If you wish to leave the game and forfeit your bet, type\n\
                 'Quit' at any point in the game.\n
                 Good Luck and when you are ready, type START\n";
  game_start()
