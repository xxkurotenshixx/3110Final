open Bjprinter
open Card
open Parser

module Hbj =
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
        | "quit" -> Bjprinter.quit ();
                    if quit_confirm ()
                    then failwith "quit"
                    else start()
        | "help" -> Bjprinter.help ();
                    start ()
      with
      | _ -> false


end