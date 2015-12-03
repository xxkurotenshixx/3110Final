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
                    if confirm ()
                    then failwith "quit"
                    else start ()
        | "help" -> Bjprinter.help ();
                    start ()
        | _ -> Bjprinter.start_prompt ();
               start ()
      with
      | _ -> false

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
