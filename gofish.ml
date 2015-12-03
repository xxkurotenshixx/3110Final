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
let print_h_hand gs : unit =
  let rec iterator h_hand =
    match h_hand with
    | last::[] -> card_to_string last ^ "." ^ iterator []
    | h::t -> card_to_string h ^ ", " ^ iterator t
    | [] -> "" in
  print_endline ("Your hand: " ^ (iterator gs.h_hand) ^ "\n")

(* draws multiple cards *)
let rec draw_multi (acc:card list) (draw_pile:deck) count : (card list * deck) =
    if count = 0 then (acc, draw_pile)
    else
      let draw_result = draw draw_pile in
      draw_multi ((fst draw_result)::acc) (snd draw_result) (count - 1)

(* Returns the starting initial game_state *)
let init_gs () : game_state =
  let h_result = draw_multi [] new_deck 5 in
  let ai1_result = draw_multi [] (snd h_result) 5 in
  let ai2_result = draw_multi [] (snd ai1_result) 5 in
  let ai3_result = draw_multi [] (snd ai2_result) 5 in
  {h_books = 0; ai1_books = 0; ai2_books = 0; ai3_books = 0;
   h_hand = fst h_result; ai1_hand = fst ai1_result;
   ai2_hand = fst ai2_result; ai3_hand = fst ai3_result;
   history = []; deck = snd ai3_result}

(* Prints the rules to the screen *)
let init_rules () : unit =
  print_endline
  ("Each player gets five cards. If you are dealt a four of a kind, or get four of a kind during game play, those cards are removed from your hand, and you get a point.

Moving clockwise, players take turns asking a specific player for a given rank of card. If someone asks you for a rank that you have, the cards are taken from your hand. if you do not have any cards of that rank, your opponent must go fish, taking one new card from the pile of cards.

When it’s your turn, select a player you think might have a needed card. Pick one card from your hand of the desired rank. If the player has the desired card, he or she must pass it over. If not, you must go fish. If you get the card you asked for, you get to go again.

If you run out of cards and there are still cards left, you get five free cards.

Play continues until all hands are empty and there are no more cards to draw from. The winner is the player with the most points at the end of the game.\n")

(* Checks if player p has a book in their hand and updates gs accordingly *)
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
  let rec announce_books ranks =
    match ranks with
    | h::t ->
      let str_to_print =
        "Book of "^(rank_to_string h)^" played by "^(player_to_string p)^"." in
      print_endline (str_to_print);
      announce_books t
    | [] -> () in
  announce_books ranks_to_extract;
  let rec update_history history acc =
    match history with
    | (rank, player)::t ->
      if List.mem rank ranks_to_extract then update_history t acc
      else update_history t ((rank, player)::acc)
    | [] -> acc in
  gs.history <- update_history gs.history [];
  match p with
  | H ->
    gs.h_books <- gs.h_books + num_new_books;
    gs.h_hand <- new_hand;
    if gs.h_hand = []
    then
      let num_to_draw = min 5 (size gs.deck) in
      let result = draw_multi [] gs.deck num_to_draw in
      let () =
        print_endline ("No more cards in hand. Drawing " ^
                       string_of_int num_to_draw ^ ".") in
      gs.h_hand <- fst result;
      gs.deck <- snd result
    else ()
  | AI1 ->
    gs.ai1_books <- gs.ai1_books + num_new_books;
    gs.ai1_hand <- new_hand;
    if gs.ai1_hand = []
    then
      let num_to_draw = min 5 (size gs.deck) in
      let result = draw_multi [] gs.deck num_to_draw in
      let () =
        print_endline ("No more cards in hand. Drawing " ^
                       string_of_int num_to_draw ^ ".") in
      gs.ai1_hand <- fst result;
      gs.deck <- snd result
    else ()
  | AI2 ->
    gs.ai2_books <- gs.ai2_books + num_new_books;
    gs.ai2_hand <- new_hand;
    if gs.ai2_hand = []
    then
      let num_to_draw = min 5 (size gs.deck) in
      let result = draw_multi [] gs.deck num_to_draw in
      let () =
        print_endline ("No more cards in hand. Drawing " ^
                       string_of_int num_to_draw ^ ".") in
      gs.ai2_hand <- fst result;
      gs.deck <- snd result
    else ()
  | AI3 ->
    gs.ai3_books <- gs.ai3_books + num_new_books;
    gs.ai3_hand <- new_hand;
    if gs.ai3_hand = []
    then
      let num_to_draw = min 5 (size gs.deck) in
      let result = draw_multi [] gs.deck num_to_draw in
      let () =
        print_endline ("No more cards in hand. Drawing " ^
                       string_of_int num_to_draw ^ ".") in
      gs.ai3_hand <- fst result;
      gs.deck <- snd result
    else ()


let rec history_to_ranklist h =
  match h with
  | (rank, player)::t -> rank::(history_to_ranklist t)
  | [] -> []

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
    else
      print_endline ("\nCard drawn by " ^ (player_to_string asker) ^ ".");
      let (card, new_deck) = draw gs.deck in
      (begin
      match asker with
      | H -> gs.h_hand <- (card::gs.h_hand)
      | AI1 -> gs.ai1_hand <- (card::gs.ai1_hand)
      | AI2 -> gs.ai2_hand <- (card::gs.ai2_hand)
      | AI3 -> gs.ai3_hand <- (card::gs.ai3_hand)
      end);
      gs.deck <- new_deck;
      if asker = H then print_h_hand gs else ()
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
      | H -> gs.h_hand <- (keep)
      | AI1 -> gs.ai1_hand <- (keep)
      | AI2 -> gs.ai2_hand <- (keep)
      | AI3 -> gs.ai3_hand <- (keep)) in
    true

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

let rec rank_to_ask () : rank option =
  print_endline ("What rank will you ask for?");
  let input = parse () in
  if List.length input >= 1
  then
    begin
    match String.lowercase (List.nth input 0) with
    | "quit" -> None
    | "help" -> init_rules (); rank_to_ask ()
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
    | _ -> print_endline ("Invalid input.\n"); rank_to_ask ()
    end
  else
    rank_to_ask ()

(****************************************************************************)




let h_turn gs =
  let () = print_h_hand gs in
  let target = who_to_ask () in
  if target = None then let () = gs.ai1_books <- 14 in false
  else
    let rank = rank_to_ask () in
    if rank = None then let () = gs.ai1_books <- 14 in false
    else
      match (target, rank) with
      | (Some t, Some r) -> transfer H t r gs
      | _ -> failwith "Error in if-logic"



let ai_turn ai rank gs =
  Thread.delay 2.;
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
    | (r, p)::t -> if rank = r then p else find_target t
    | [] -> random_player () in
  transfer ai (find_target gs.history) rank gs



let rec turn p gs =
  let endgame =
    gs.h_books + gs.ai1_books + gs.ai2_books + gs.ai3_books >= 13 in
  if endgame
  then
    let h_win =
      gs.h_books > gs.ai1_books &&
      gs.h_books > gs.ai2_books &&
      gs.h_books > gs.ai3_books in
    h_win
  else
    match p with
    | H ->
      if h_turn gs
      then let () = check_for_books p gs in turn H gs
      else let () =
        (print_endline "--------------------------------------------------");
         check_for_books p gs in turn AI1 gs
    | AI1 ->
      let from_hist = ai_decide gs.ai1_hand (history_to_ranklist gs.history) in
      let rank_ask =
        match from_hist with
        | None -> choose_random gs.ai1_hand
        | Some r -> r in
      if ai_turn p rank_ask gs
      then let () = check_for_books p gs in turn AI1 gs
      else let () =
        (print_endline "--------------------------------------------------");
         check_for_books p gs in turn AI2 gs
    | AI2 ->
      let from_hist = ai_decide gs.ai2_hand (history_to_ranklist gs.history) in
      let rank_ask =
        match from_hist with
        | None -> choose_random gs.ai2_hand
        | Some r -> r in
      if ai_turn p rank_ask gs
      then let () = check_for_books p gs in turn AI2 gs
      else let () =
        (print_endline "--------------------------------------------------");
         check_for_books p gs in turn AI3 gs
    | AI3 ->
      let from_hist = ai_decide gs.ai3_hand (history_to_ranklist gs.history) in
      let rank_ask =
        match from_hist with
        | None -> choose_random gs.ai3_hand
        | Some r -> r in
      if ai_turn p rank_ask gs
      then let () = check_for_books p gs in turn AI3 gs
      else let () =
        (print_endline "--------------------------------------------------");
         check_for_books p gs in turn H gs

let run (wager : int) : int =
  let () = init_rules () in
  let gs = init_gs () in
  if (turn H gs) then (2 * wager) else 0

