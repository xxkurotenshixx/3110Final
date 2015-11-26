
let points_to_caml score =
  if score < 0 then
    "Dead Caml"
  else if score < 500 then
    "Calf"
  else if score = 500 then
    "Camlflaged"
  else if score > 1150 then
    "ACaml"
  else if score > 1800 then
    "BCaml"
  else if score > 2450 then
    "CCaml"
  else if score > 3100 then
    "DCaml"
  else if score > 3750 then
    "ECaml"
  else if score > 4400 then
    "FCaml"
  else if score > 5050 then
    "GCaml"
  else if score > 5700 then
    "HCaml"
  else if score > 6350 then
    "ICaml"
  else if score > 7000 then
    "JCaml"
  else if score > 7650 then
    "KCaml"
  else if score > 8300 then
    "LCaml"
  else if score > 8950 then
    "MCaml"
  else if score > 9600 then
    "NCaml"
  else if score > 10000 then
    "OCaml: King of Camllot"

let parse_input =
  let input = Parser.parse in
  let _ = print_string "\n\n" in
  match l with
  | ("play")::("blackjack")::_  -> Game 1
  | ("play")::("bull")::("shit")::_  -> Game 2
  | ("play")::("go")::("fish")::_  -> Game 3
  | ("play")::_ -> Game 0
  | ("y")::_ | ("yes")::_ -> Confirm true
  | ("n")::_ | ("no")::_ -> Confirm false
  | ("check")::_ -> Check
  | ("quit")::_ -> Quit
  | ("help")::_ -> help
  | [] -> Nul
  | _ -> Gibberish

let get_bid max =
  let _ = print_string "How much would you like to bid?\n\n" in
  let rec bid score =
    try
      let num = read_int in
      if num < 0 then
        let _ = print_string "Please type in a positive integer\n\n" in
        get_bid score
      else if num > score then
        let _ = print_string "You dont have that much money, bid less\n\n" in
        get_bid score
      else
        num
    with
    | Failure "int_of_string" ->
      let _ = print_string "Please type in a positive integer\n\n" in
        get_bid score
  in
  bid max

let rec get_quit_conf =
  let _ = print_string "Are you sure you want to quit (y/n)?\n\n" in
  match parse_input with
  | Confirm x -> x
  | _         ->
    let _ = print_string "Please answer yes or no\n\n" in
    get_quit_conf

let rec run score =
  let input = parse_input in
  match input with
  | Game 0 -> let _ = print_string
          "You can \"play blackjack\", \"play bull shit\", or
          \"play go fish\"\n\n" in
          run new_score
  | Game 1 -> let new_score = Blackjack.run score in
        let _ = print_string "Welcome back to the lobby \n\n" in
        run new_score
  | Game 2 -> let bid = get_bid in
        let new_score = (Bullshit.run bid) + score in
        let _ = print_string "Welcome back to the lobby!\n\n" in
        run new_score
  | Game 3 -> let bid = get_bid in
        let new_score = (Gofish.run bid) + score in
        let _ = print_string "Welcome back to the lobby!\n\n" in
        run new_score
  | Check  -> let _ = printf "You have %d currently in the bank\n" score in
        let _ = printf "You currently have %s status\n\n" (points_to_ocaml score) in
        run score
  | Quit   -> let really = get_quit_conf in
        if really then
          score
        else
          run score
  | Help   -> let _ = print_string "You ask a passerby for help.
                    He seems a bit miffed, his pockets empty,
                    but he decided to tell you a thing or two about making it
                    here in Camllot\n\n play: \"try your luck and play a game\"\n
                      play (blackjack || bull shit || go fish)
                    check: \"check your pockets, see how much change you got\"\n
                    quit: \"cash in your money and git gone\"\n
                    help: \"your looking at it\"\n\n" in
        run score
  | Nul    -> let _ = print_string "You might want to type something.
                      Type in \"help\" to ask for help.\n\n" in
        run score
  | Confirm x  -> if x then
            let _ = print_string "You yell \"YES\" like a maniac.
                        People start looking.
                        You might want to ask for \"help\" before you make an
                          even bigger fool of yourself.\n\n" in
              run score
          else
            let _ = print_string "You yell \"NO\" like a maniac.
                        People start looking.
                        You might want to ask for \"help\" before you make an
                          even bigger fool of yourself.\n\n" in
            run score
  | Gibberish  -> let _ = print_string "No one knows what your saying.
                      Everyone's looking at you funny now.
                      Nice going. You might want to ask for \"help\"
                      before you make and even bigger fool of yourself.\n\n" in
            run score


let start =
  let start_score = 500 in
  let final_score = run score in
  let _ = printf "You decide to leave this world of high stakes risks and
      OCaml puns.
      You take one last look at the doorway before you walk away.
      You check your pockets.\n\n
      You made it out with %d. That makes you \"%a\"."
      final_score (points_to_ocaml final_score) in
  let _ = parse_input in
  ()



