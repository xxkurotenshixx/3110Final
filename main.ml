type input = Quit | Check | Game of int | Help | Gibberish

let points_to_caml score =
  if score < 0 then "Dead Caml"
  else if score < 500 then "Calf"
  else if score = 500 then "Camlflaged"
  else if score < 1150 then "ACaml"
  else if score < 1800 then "BCaml"
  else if score < 2450 then "CCaml"
  else if score < 3100 then "DCaml"
  else if score < 3750 then "ECaml"
  else if score < 4400 then "FCaml"
  else if score < 5050 then "GCaml"
  else if score < 5700 then "HCaml"
  else if score < 6350 then "ICaml"
  else if score < 7000 then "JCaml"
  else if score < 7650 then "KCaml"
  else if score < 8300 then "LCaml"
  else if score < 8950 then "MCaml"
  else if score < 10000 then "NCaml"
  else "OCaml: King of Camllot"

let parse_input () =
  let input = Parser.parse () in
  match input with
  | "play"::"blackjack"::_ | "blackjack"::_ -> Game 1
  | "play"::"bullshit"::_ | "bullshit"::_ -> Game 2
  | "play"::"go"::"fish"::_ | "go"::"fish"::_  -> Game 3
  | "play"::_ -> Game 0
  | "check"::_ -> Check
  | "quit"::_ -> Quit
  | "help"::_ -> Help
  | _ -> Gibberish

let get_bid max =
  let _ = print_string " How much would you like to bid?\n" in
  let rec bid score =
    try
      let num = read_int () in
      if num <= 0 then
        let _ = print_string " Please type in a positive integer\n" in
        bid score
      else if num > score then
        let _ = print_string " You dont have that much money, bid less\n" in
        bid score
      else
        num
    with
    | Failure "int_of_string" ->
       let _ = print_string " Please type in a positive integer\n" in
       bid score in
  bid max

let help () =
  let message = " You ask a passerby for help. He seems a bit miffed,\n" ^
                " his pockets empty, but he decided to tell you a thing\n" ^
                " or two about making it here in Camllot.\n" ^
                " Try your luck and play a game:\n \
                  play: (blackjack || bullshit || go fish)\n \
                  check: \"check your pockets, see how much change you got\"\n"^
                " quit: \"cash in your money and git gone\"\n"^
                " help: \"your looking at it\"\n" in
  Printf.printf "%s" message

let rec run score =
  let message = "Welcome back to the lobby!\n\n" in
  let input = parse_input () in
  match input with
  | Game 1 -> let new_score = Blackjack.run score in
              Printf.printf "%s" message; run new_score
  | Game 2 -> let bid = get_bid score in
              let new_score = (Bullshit.run bid) + score in
              Printf.printf "%s" message; run new_score
  | Game 3 -> let bid = get_bid score in
              let new_score = (Gofish.run bid) + score in
              Printf.printf "%s" message; run new_score
  | Game _ -> Printf.printf "You can only play blackjack, bullshit, or \
                             go fish.\n\n"; run score
  | Check  ->
     Printf.printf "You have %d currently in the bank\n" score;
     Printf.printf "You currently have %s status\n\n" (points_to_caml score);
     run score
  | Quit   -> Printf.printf " Are you sure you want to leave? (y/n)\n";
              if Parser.confirm () then score
              else let _ = Printf.printf "%s" message in run score
  | Help   -> help (); run score
  | Gibberish  ->
     let message = "No one knows what your saying.
                    Everyone's looking at you funny now.
                    Nice going. You might want to ask for \"help\"
                    before you make and even bigger fool of yourself.\n" in
     Printf.printf "%s" message; run score


let _ =
  let start_score = 500 in
  Printf.printf "Welcome to Camllot! If you need any help, ask a stranger \
                 by saying \"help\".\n";
  let final_score = run start_score in
  let message = " You decide to leave this world of high stakes risks and\n" ^
                " Ocaml puns. You take one last look at the doorway before\n" ^
                " you walk away. You check your pockets.\n" in
  Printf.printf "%s You made it out with %d. That makes you\n \"%s\"\n"
                message final_score (points_to_caml final_score)
