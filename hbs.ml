open Bsprint
open Card
open Parser

let rec start () =
  let input = parse () in
  match List.nth input 0 with
  | "start" -> true
  | "quit" ->
     quit ();
     if confirm () then false
     else
       let _ = start_prompt () in
       start ()
  | "help" -> help ();
              start ()
  | "rules" -> rules ();
               start ()
  | _ -> start_prompt ();
         start ()

let rec play_cards n hands =
  let rec helper h acc =
    match h with
    | [] -> acc
    | hd::tl -> helper tl (List.exists (same_card hd) hands) in
  let input = parse () in
  if List.length input = 1 then
    match List.nth input 0 with
    | "help" -> help ();
                play_cards n hands
    | "hand" -> print_hand hands;
                play_cards n hands
    | "quit" -> quit ();
                if confirm ()
                then failwith "quit"
                else play_cards n hands
    | "rules" -> rules ();
                 play_cards n hands
    | _ ->
       play_cards n hands
  else
    try
      let sl = Str.split (Str.regexp ",") (List.nth input 0) in
      let cl = List.map string_to_card (List.tl input) in
      if helper cl true
      then
        try (cl, int_of_string (List.nth sl 0),
             string_to_rank (List.nth sl 1)) with
        | _ -> hand_format_prompt ();
               play_cards n hands
      else play_cards n hands
    with
    | _ -> hand_format_prompt ();
           play_cards n hands

let rec call_bs hand =
  let input = parse () in
  if List.length input = 1 then
    match List.nth input 0 with
    | "y" -> true
    | "n" -> false
    | "hands" -> print_hand hand;
                 call_bs hand
    | "help" -> help ();
                call_bs hand
    | "rules" -> rules ();
                 call_bs hand
    | "quit" -> quit ();
                if confirm ()
                then failwith "quit"
                else call_bs hand
    | _ -> bs_prompt ();
           call_bs hand
  else
    let _ = bs_prompt () in
    call_bs hand
