open Card
open Deck
open Ai_for_gofish
open Parser

type player = H | AI1 | AI2 | AI3

type game_state =
  {mutable h_books : int;
   mutable ai1_books : int;
   mutable ai2_books : int;
   mutable ai3_books : int;
   mutable h_hand : card list;
   mutable ai1_hand : card list;
   mutable ai2_hand : card list;
   mutable ai3_hand : card list;
   mutable history : (rank * player) list;
   mutable deck : deck}

(* Helper functions *)
(***************************************************************************)
(* Returns the string associated with the player p *)
let player_to_string p =
  match p with
  | H -> "You"
  | AI1 -> "Walker"
  | AI2 -> "David"
  | AI3 -> "Mike"

(* Returns the string associated with the rank r  *)
let rank_to_string r =
  match r with
  | Ace -> "Aces"
  | Two -> "Twos"
  | Three -> "Threes"
  | Four -> "Fours"
  | Five -> "Fives"
  | Six -> "Sixes"
  | Seven -> "Sevens"
  | Eight -> "Eights"
  | Nine -> "Nines"
  | Ten -> "Tens"
  | Jack -> "Jacks"
  | Queen -> "Queens"
  | King -> "Kings"

(* Prints the human player's hand *)
let print_hand p gs : unit =
  let rec iterator hand =
    match hand with
    | last::[] -> card_to_string last ^ "." ^ iterator []
    | h::t -> card_to_string h ^ ", " ^ iterator t
    | [] -> "" in
  match p with
  | H -> print_endline ("Your hand: " ^ (iterator gs.h_hand) ^ "\n")
  | AI1 -> print_endline ("Walker's hand: " ^ (iterator gs.ai1_hand) ^ "\n")
  | AI2 -> print_endline ("David's hand: " ^ (iterator gs.ai2_hand) ^ "\n")
  | AI3 -> print_endline ("Mike's hand: " ^ (iterator gs.ai3_hand) ^ "\n")

(* Prints the request history *)
let print_history gs : unit =
  let rec iterator history =
    match history with
    | (r, p)::[] -> "(" ^ rank_to_string r ^ ", " ^ player_to_string p ^ ")." ^ iterator []
    | (r, p)::t -> "(" ^ rank_to_string r ^ ", " ^ player_to_string p ^ "), " ^ iterator t
    | [] -> "" in
  print_endline ("History: " ^ iterator gs.history)

(* Prints the size of the remaining deck *)
let print_deck_size gs : unit =
  print_endline ("Deck size: " ^ string_of_int (size gs.deck))

(* Prints the number of books played by each player *)
let print_books gs : unit =
  print_endline ("Number of books- You: " ^ string_of_int gs.h_books ^
                 ", Walker: " ^ string_of_int gs.ai1_books ^
                 ", David: " ^ string_of_int gs.ai2_books ^
                 ", Mike: " ^ string_of_int gs.ai3_books ^ ".")

(* Prints the current game state's components *)
let omniscient gs : unit =
  print_endline( "********************************************************");
  print_hand H gs;
  print_hand AI1 gs;
  print_hand AI2 gs;
  print_hand AI3 gs;
  print_history gs;
  print_books gs;
  print_deck_size gs;
  print_endline( "********************************************************")

(* Returns the tuple ([n drawn cards], updated deck) *)
let rec draw_multi (acc:card list) (draw_pile:deck) n : (card list * deck) =
    if n = 0 then (acc, draw_pile)
    else
      let draw_result = draw draw_pile in
      draw_multi ((fst draw_result)::acc) (snd draw_result) (n - 1)

(* Adds or updates (rank, player) to the request history *)
let rec add_to_history (rank, player) history gs acc =
  match history with
  | [] -> gs.history <- ((rank, player)::gs.history)
  | (r, p):: t ->
    if rank = r then gs.history <- (acc @ [(rank, player)] @ t)
    else add_to_history (rank, player) t gs ((r, p)::acc)

(* Returns the initial game_state *)
let init_gs () : game_state =
  let h_result = draw_multi [] new_deck 5 in
  let ai1_result = draw_multi [] (snd h_result) 5 in
  let ai2_result = draw_multi [] (snd ai1_result) 5 in
  let ai3_result = draw_multi [] (snd ai2_result) 5 in
  {h_books = 0; ai1_books = 0; ai2_books = 0; ai3_books = 0;
   h_hand = fst h_result; ai1_hand = fst ai1_result;
   ai2_hand = fst ai2_result; ai3_hand = fst ai3_result;
   history = []; deck = snd ai3_result}

(* Prints the rules *)
let init_rules () : unit =
  print_endline
  ("\nplayers take turns asking a specific player for a given rank of card. If someone asks you for a rank that you have, the cards are taken from your hand. if you do not have any cards of that rank, your opponent must go fish, taking one new card from the pile of cards.

When it’s your turn, select a player you think might have a needed card. Pick one card from your hand of the desired rank. If the player has the desired card, he or she must pass it over. If not, you must go fish. If you get the card you asked for, you get to go again.

If you run out of cards and there are still cards left, you get five free cards.

Play continues until all hands are empty and there are no more cards to draw from. The winner is the player with the most points at the end of the game. Rules were found on: http://www.hoylegaming.com/rules/showrule.aspx?RuleID=214

You will be playing with Walker, David, and Mike. Have fun!\n--------------------------------------------------\n")

(* Makes p draw 5 cards. Updates gs accordingly. *)
let redraw p gs =
  let num_to_draw = min 5 (size gs.deck) in
  let result = draw_multi [] gs.deck num_to_draw in
  let () =
      print_endline (player_to_string p ^": No more cards in hand. Drawing "
                     ^ string_of_int num_to_draw ^ ".") in
  gs.deck <- snd result;
  match p with
  | H -> gs.h_hand <- fst result
  | AI1 -> gs.ai1_hand <- fst result
  | AI2 -> gs.ai2_hand <- fst result
  | AI3 -> gs.ai3_hand <- fst result

(* Checks if player p has books in their hand and updates gs accordingly *)
let check_for_books (p : player) (gs : game_state) : unit =
  let hand =
    match p with
    | H -> gs.h_hand
    | AI1 -> gs.ai1_hand
    | AI2 -> gs.ai2_hand
    | AI3 -> gs.ai3_hand in
  let rank_count =
    let rec counter h nA n2 n3 n4 n5 n6 n7 n8 n9 n10 nJ nQ nK =
      match h with
      | (suit, rank)::t ->
        begin
        match rank with
        | Ace -> counter t (nA + 1) n2 n3 n4 n5 n6 n7 n8 n9 n10 nJ nQ nK
        | Two -> counter t nA (n2 + 1) n3 n4 n5 n6 n7 n8 n9 n10 nJ nQ nK
        | Three -> counter t nA n2 (n3 + 1) n4 n5 n6 n7 n8 n9 n10 nJ nQ nK
        | Four -> counter t nA n2 n3 (n4 + 1) n5 n6 n7 n8 n9 n10 nJ nQ nK
        | Five -> counter t nA n2 n3 n4 (n5 + 1) n6 n7 n8 n9 n10 nJ nQ nK
        | Six -> counter t nA n2 n3 n4 n5 (n6 + 1) n7 n8 n9 n10 nJ nQ nK
        | Seven -> counter t nA n2 n3 n4 n5 n6 (n7 + 1) n8 n9 n10 nJ nQ nK
        | Eight -> counter t nA n2 n3 n4 n5 n6 n7 (n8 + 1) n9 n10 nJ nQ nK
        | Nine -> counter t nA n2 n3 n4 n5 n6 n7 n8 (n9 + 1) n10 nJ nQ nK
        | Ten -> counter t nA n2 n3 n4 n5 n6 n7 n8 n9 (n10 + 1) nJ nQ nK
        | Jack -> counter t nA n2 n3 n4 n5 n6 n7 n8 n9 n10 (nJ + 1) nQ nK
        | Queen -> counter t nA n2 n3 n4 n5 n6 n7 n8 n9 n10 nJ (nQ + 1) nK
        | King -> counter t nA n2 n3 n4 n5 n6 n7 n8 n9 n10 nJ nQ (nK + 1)
        end
      | [] -> [nA; n2; n3; n4; n5; n6; n7; n8; n9; n10; nJ; nQ; nK] in
    counter hand 0 0 0 0 0 0 0 0 0 0 0 0 0 in
  let ranks_to_extract =
    let int_to_rank i =
      match i with
      | 1 -> Ace
      | 2 -> Two
      | 3 -> Three
      | 4 -> Four
      | 5 -> Five
      | 6 -> Six
      | 7 -> Seven
      | 8 -> Eight
      | 9 -> Nine
      | 10 -> Ten
      | 11 -> Jack
      | 12 -> Queen
      | 13 -> King
      | _ -> failwith "Invalid int" in
    let rec extract vc acc pos =
      match vc with
      | h::t ->
        extract t (if h = 4 then (int_to_rank pos)::acc else acc) (pos + 1)
      | [] -> acc in
    extract rank_count [] 1 in
  let num_new_books = List.length ranks_to_extract in
  let new_hand =
    let is_not_book c = not (List.mem (snd c) ranks_to_extract) in
    List.filter is_not_book hand in
  let rec update_history history acc =
    match history with
    | (rank, player)::t ->
      if List.mem rank ranks_to_extract then update_history t acc
      else update_history t ((rank, player)::acc)
    | [] -> acc in
  gs.history <- update_history gs.history [];
  let rec announce_books ranks =
    match ranks with
    | h::t ->
      let str_to_print =
        "Book of "^(rank_to_string h)^" played by "^(player_to_string p)^"." in
      print_endline (str_to_print);
      announce_books t
    | [] -> () in
  announce_books ranks_to_extract;
  (match p with
  | H ->
    gs.h_books <- gs.h_books + num_new_books;
    gs.h_hand <- new_hand;
    if gs.h_hand = [] then redraw p gs else ()
  | AI1 ->
    gs.ai1_books <- gs.ai1_books + num_new_books;
    gs.ai1_hand <- new_hand;
    if gs.ai1_hand = [] then redraw p gs else ()
  | AI2 ->
    gs.ai2_books <- gs.ai2_books + num_new_books;
    gs.ai2_hand <- new_hand;
    if gs.ai2_hand = [] then redraw p gs else ()
  | AI3 ->
    gs.ai3_books <- gs.ai3_books + num_new_books;
    gs.ai3_hand <- new_hand;
    if gs.ai3_hand = [] then redraw p gs else ());
  if num_new_books > 0 then print_books gs else ()


(* Returns the list of ranks in h *)
let rec history_to_ranklist self h =
  match h with
  | (rank, player)::t ->
    if player <> self then rank::(history_to_ranklist self t)
    else history_to_ranklist self t
  | [] -> []

(* Performs a transfer rank_wanted from target to asker.
   Returns true iff cards were transfered. *)
let transfer asker target rank_wanted gs =
  print_endline ("\n" ^
                 (player_to_string asker) ^
                 ": 'Got any " ^
                 (rank_to_string rank_wanted) ^
                 "?'");
  let rec filterer target_hand keep export =
    match target_hand with
    | (suit, rank)::t ->
      if rank = rank_wanted then filterer t keep ((suit, rank)::export)
      else filterer t ((suit, rank)::keep) export
    | [] -> (keep, export) in
  let target_hand =
    match target with
    | H -> gs.h_hand
    | AI1 -> gs.ai1_hand
    | AI2 -> gs.ai2_hand
    | AI3 -> gs.ai3_hand in
  let (keep, export) = filterer target_hand [] [] in
  if export = []
  then
    let () = (begin
    let () = print_endline ((player_to_string target) ^ ": 'Nope. Go fish!'") in
    if gs.deck = empty
    then print_endline ("...but there are no cards left.")
    else (
      (print_endline ("\nCard drawn by " ^ (player_to_string asker) ^ "."));
      let (card, new_deck) = draw gs.deck in
      (begin
      match asker with
      | H -> gs.h_hand <- (card::gs.h_hand)
      | AI1 -> gs.ai1_hand <- (card::gs.ai1_hand)
      | AI2 -> gs.ai2_hand <- (card::gs.ai2_hand)
      | AI3 -> gs.ai3_hand <- (card::gs.ai3_hand)
      end);
      gs.deck <- new_deck;
      if asker = H then print_hand H gs else ())
    end) in
    false
  else
    let () =
      print_endline ((player_to_string target) ^ " : 'Yes.'");
      print_endline ((rank_to_string rank_wanted) ^
                     " given to " ^
                     (player_to_string asker) ^
                     ".");
      (begin
      match asker with
      | H -> gs.h_hand <- (export @ gs.h_hand)
      | AI1 -> gs.ai1_hand <- (export @ gs.ai1_hand)
      | AI2 -> gs.ai2_hand <- (export @ gs.ai2_hand)
      | AI3 -> gs.ai3_hand <- (export @ gs.ai3_hand)
      end);
      (match target with
      | H -> gs.h_hand <- keep
      | AI1 -> gs.ai1_hand <- keep
      | AI2 -> gs.ai2_hand <- keep
      | AI3 -> gs.ai3_hand <- keep) in
    true

(* Prompts the user to input who to ask *)
let rec who_to_ask () : player option =
  print_endline ("Who will you ask?");
  let input = parse () in
  if List.length input >= 1
  then
    begin
    match String.lowercase (List.nth input 0) with
    | "quit" -> None
    | "help" -> init_rules (); who_to_ask ()
    | "walker" -> Some AI1
    | "david" -> Some AI2
    | "mike" -> Some AI3
    | _ -> print_endline ("Invalid input.\n"); who_to_ask ()
    end
  else
    who_to_ask ()

(* Prompts the user to input what rank to ask for *)
let rec rank_to_ask gs : rank option =
  print_endline ("What rank will you ask for?");
  let input = parse () in
  let request =
    if List.length input >= 1
    then
      begin
      match String.lowercase (List.nth input 0) with
      | "quit" -> None
      | "help" -> init_rules (); rank_to_ask gs
      | "ace" -> Some Ace
      | "aces" -> Some Ace
      | "two" -> Some Two
      | "twos" -> Some Two
      | "three" -> Some Three
      | "threes" -> Some Three
      | "four" -> Some Four
      | "fours" -> Some Four
      | "five" -> Some Five
      | "fives" -> Some Five
      | "six" -> Some Six
      | "sixes" -> Some Six
      | "seven" -> Some Seven
      | "sevens" -> Some Seven
      | "eight" -> Some Eight
      | "eights" -> Some Eight
      | "nine" -> Some Nine
      | "nines" -> Some Nine
      | "ten" -> Some Ten
      | "tens" -> Some Ten
      | "jack" -> Some Jack
      | "jacks" -> Some Jack
      | "queen" -> Some Queen
      | "queens" -> Some Queen
      | "king" -> Some King
      | "kings" -> Some King
      | _ -> print_endline ("Invalid input.\n"); rank_to_ask gs
      end
    else
      rank_to_ask gs
    in
  match request with
  | None -> None
  | Some rank ->
    let ranks_owned = List.map (fun (_, r) -> r) gs.h_hand in
    if List.mem rank ranks_owned then Some rank
    else
      let () = print_endline "You can't ask for a rank you don't own.\n" in
      rank_to_ask gs

(* Simulates the user's asking for card.
   Returns true iff cards were transfered *)
let h_turn gs =
  let () = print_hand H gs in
  let target = who_to_ask () in
  if target = None then let () = gs.ai1_books <- 14 in false
  else
    let rank = rank_to_ask gs in
    if rank = None then let () = gs.ai1_books <- 14 in false
    else
      match (target, rank) with
      | (Some t, Some r) ->
        add_to_history (r, H) gs.history gs [];
        transfer H t r gs
      | _ -> failwith "Error in if-logic"

(* Simulates ai's asking for a card. Returns true iff cards were transfered *)
let ai_turn ai rank gs =
  Thread.delay 1.;
  let random_player () =
    let rand_int =
      let _ = Random.self_init() in
      Random.int 3 in
    let is_not_me p = ai <> p in
    let p_list = [H; AI1; AI2; AI3] in
    let to_choose = List.filter is_not_me p_list in
    List.nth to_choose rand_int in
  let rec find_target history =
    match history with
    | (r, p)::t ->
      if (rank = r && ai <> p) then p else find_target t
    | [] -> random_player () in
  let target = find_target gs.history in
  add_to_history (rank, ai) gs.history gs [];
  transfer ai target rank gs

(* Simulates p asking for a card. Continues to recursively call itself until
   the game is over. Returns true iff user wins.*)
let rec turn p gs =
  (* Uncomment line below to see game state as game runs *)
  (*omniscient gs;*)
  let total_points =
    gs.h_books + gs.ai1_books + gs.ai2_books + gs.ai3_books in
  if total_points > 13
  then
    let () = print_endline "Quitters never win!" in
    false
  else if total_points = 13
  then
    let () = print_endline "No more cards in play" in
    let h_win =
      gs.h_books > gs.ai1_books &&
      gs.h_books > gs.ai2_books &&
      gs.h_books > gs.ai3_books in
    (if h_win then print_endline "You win!" else print_endline "You lose!");
    h_win
  else
    let next_player =
      match p with
      | H -> AI1
      | AI1 -> AI2
      | AI2 -> AI3
      | AI3 -> H in
    let empty_deck_case p gs =
      let () = print_endline (player_to_string p ^ ": Deck is empty. :(") in
      (print_endline "--------------------------------------------------");
      turn next_player gs in
    let next_action b p gs =
      let () = check_for_books p gs in
      if b then turn p gs else turn next_player gs in
    let get_rank p gs =
      let hand =
        match p with
        | AI1 -> gs.ai1_hand
        | AI2 -> gs.ai2_hand
        | AI3 -> gs.ai3_hand
        | H -> failwith "Don't use this method for user." in
      let from_hist = ai_decide hand (history_to_ranklist p gs.history) in
      (match from_hist with
      | None -> choose_random hand
      | Some r -> r) in
    match p with
    | H ->
      (if gs.h_hand = [] then redraw p gs else ());
      if gs.h_hand = [] then empty_deck_case p gs
      else next_action (h_turn gs) p gs
    | AI1 ->
      (if gs.ai1_hand = [] then redraw p gs else ());
      if gs.ai1_hand = [] then empty_deck_case p gs
      else next_action (ai_turn p (get_rank p gs) gs) p gs
    | AI2 ->
      (if gs.ai2_hand = [] then redraw p gs else ());
      if gs.ai2_hand = [] then empty_deck_case p gs
      else next_action (ai_turn p (get_rank p gs) gs) p gs
    | AI3 ->
      (if gs.ai3_hand = [] then redraw p gs else ());
      if gs.ai3_hand = [] then empty_deck_case p gs
      else next_action (ai_turn p (get_rank p gs) gs) p gs

(****************************************************************************)

let run (wager : int) : int =
  let () = init_rules () in
  let gs = init_gs () in
  if (turn H gs) then (2 * wager) else 0
