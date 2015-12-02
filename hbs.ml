open Bsprint
open Card
open Parser
module Hbs =
  struct
    let rec quit_confirm () =
      let input = Parser.parse () in
      try
        match List.nth input 0 with
        | "y" -> true
        | "n" -> false
        | _ -> quit_confirm ()
      with
      | _ -> quit_confirm ()

    let rec start () =
      let input = Parser.parse () in
      try
        match List.nth input 0 with
        | "start" -> true
        | "quit" -> Bsprint.quit ();
                    quit_confirm ()
        | "help" -> Bsprint.help ();
                    start ()
        | _ -> Bsprint.starter ();
               start ()
      with
      | _ -> Bsprint.starter ();
             start ()

    let rec play_cards n hands =
      let rec helper h acc =
        match h with
        | [] -> acc
        | hd::tl -> helper tl (List.exists (fun x -> hd = x) hands) in
      let input = Parser.parse () in
      if List.length input = 0 then
        play_cards n hands
      else if List.length input = 1 then
        match List.nth input 0 with
        | "help" -> Bsprint.help ();
                    play_cards n hands
        | "hands" -> Bsprint.print_hand hands;
                     play_cards n hands
        | "quit" -> Bsprint.quit ();
                    if quit_confirm ()
                    then failwith "quit"
                    else play_cards n hands
        | _ -> play_cards n hands
      else
        try
          let sl = Str.split (Str.regexp ", ") (List.nth input 0) in
          let cl = List.map Card.string_to_card (List.tl input) in
          if helper cl true
          then
            try (cl, int_of_string (List.nth sl 0),
                 Card.string_to_rank (List.nth sl 1)) with
            | _ -> play_cards n hands
          else play_cards n hands
        with
        | _ -> play_cards n hands

    let rec call_bs hand =
      let input = Parser.parse () in
      if List.length input = 1 then
        match List.nth input 0 with
        | "y" -> true
        | "n" -> false
        | "hands" -> Bsprint.print_hand hand;
                     call_bs hand
        | "help" -> Bsprint.help ();
                    call_bs hand
        | "quit" -> Bsprint.quit ();
                    if quit_confirm ()
                    then failwith "quit"
                    else call_bs hand
        | _ -> Bsprint.bs_prompt ();
               call_bs hand
      else
        let _ = Bsprint.bs_prompt in
        call_bs hand
  end
