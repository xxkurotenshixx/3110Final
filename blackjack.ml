module Blackjack = struct

  let rec player_turn s =
    Bjprinter.player_prompt (Bjupdater.player s);
    if Hbj.play ()
    then
      let ns = Bjupdater.hit s "player" in
      if Bjupdater.pbust s
      then ns
      else player_turn ns
    else
      s

  let rec dealer_turn s =
    if Bjupdater.ddraw s
    then
      let ns = Bjupdater.hit s "dealer" in
      if Bjupdater.dbust ns
      then
        ns
      else dealer_turn ns
    else
      s

  let rec runner s =
    Bjprinter.start_prompt ();
    let bid = Hbj.start Bjupdater.money s in
    if bid < 0
    then runner s
    else
      let ns = Bjupdater.new_game_deal bid s in
      if Bjupdater.dbust ns
      then let _ = Bjprinter.round_won () in
           if Hbj.confirm ()
           then runner (Bjupdater.round_won bid ns)
           else (Bjupdater.round_won bid ns)
      else
        if Bjupdater.pbust ns
        then
          let _ = Bjprinter.round_lost () in
          if Hbj.confirm ()
          then runner ns
          else ns
        else
          try
            let os = player_turn ns in
            if Bjupdater.pbust os
            then
              let _ = Bjprinter.round_lost () in
              if Hbj.confirm ()
              then runner ns
              else ns
            else
              let fs = dealer_turn ns in
              if Bjupdater.dbust fs
              then
                let _ = Bjprinter.round_won () in
                if Hbj.confirm ()
                then runner fs
                else fs
              else
                if Bjupdater.status fs = 0
                then
                  let _ = game_tie () in
                  if Hbj.confirm ()
                  then runner fs
                  else fs
                else
                  if Bjupdater.status fs = 1
                  then
                    let _ = round_won () in
                    if Hbj.confirm ()
                    then runner fs
                    else fs
                  else
                    let _ = round_lost () in
                    if Hbj.confirm ()
                    then runner fs
                    else fs
          with
          | _ -> ns

  let run money =
    Bjprinter.welcome ();
    Bjprinter.rules ();
    let s = runner (Bjupdater.new_table money) in
    Bjprinter.leave money (Bjupdater.money s) (Bjupdater.rounds s);
    Bjupdater.money s
end
