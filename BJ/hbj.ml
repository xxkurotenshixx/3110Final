open Bjprinter
open Parser

let rec start money =
  let input = parse () in
  match List.nth input 0 with
  | "start" -> true
  | "quit" -> quit ();
              if confirm () then false
              else let _ = start_prompt () in start money
  | "help" -> help (); start money
  | "rules" -> rules(); start money
  | "money" -> wallet money; start money
  | _ -> start_prompt (); start money

let rec bid money =
  let input = parse () in
  match List.nth input 0 with
  | "quit" -> quit ();
              if confirm () then failwith "quit"
              else bid money
  | "help" -> help (); bid money
  | "rules" -> rules (); bid money
  | "money" -> wallet money; bid money
  | x ->
     try
       let b = int_of_string x in
       if b <= 0 || b > money
       then let _ = bid_prompt () in bid money
       else b
     with
     | _ -> let _ = bid_prompt () in bid money

let rec play money =
  let input = parse () in
  match List.nth input 0 with
  | "help" -> help (); play money
  | "stand" -> false
  | "hit" -> true
  | "rules" -> rules (); play money
  | "money" -> wallet money; play money
  | "quit" -> quit ();
              if confirm () then failwith "quit"
              else play money
  | _ -> player_prompt (); play money
