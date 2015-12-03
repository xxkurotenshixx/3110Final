open Bjprinter
open Card
open Parser

module Hbj =
  struct
    let rec confirm () =
      let input = Parser.parse () in
         try
           match List.nth input 0 with
           | "y" -> true
           | "n" -> false
           | _ -> confirm ()
         with
         | _ -> confirm ()

    let rec start () =
      let input = Parser.parse () in
      try
        match List.nth input 0 with
        | "start" -> true
        | "quit" -> Bjprinter.quit ();
                    confirm ()
        | "help" -> Bjprinter.help ();
                    start ()
        | _ -> Bjprinter.start_prompt ();
               start ()
      with
      | _ -> Bjprinter.start_prompt ();
             start ()

    let rec bid money =
      let input = Parser.parse () in
      try
        match List.nth input 0 with
        | "quit" -> Bjprinter.quit ();
                    if confirm ()
                    then failwith "quit"
                    else bid money
        | "help" -> Bjprinter.help ();
                    bid money
        | x -> let b = int_of_string x in
               if b <= 0 || b > money
               then
                 let _ = Bjprinter.bid_prompt () in
                 bid money
               else b
      with
      | Failure "int_of_string" -> bid money
      | _ -> failwith "quit"

    let rec play () =
      let input = Parser.parse () in
      if List.length input = 0
      then play ()
      else
        match List.nth input 0 with
        | "help" -> Bjprinter.help ();
                    play()
        | "stand" -> false
        | "hit" -> true
        | "quit" -> Bjprinter.quit ();
                    if confirm ()
                    then failwith "quit"
                    else play ()
        | _ -> Bjprinter.prompt ();
               play()

end
