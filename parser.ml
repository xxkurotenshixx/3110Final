module Parser = struct
  let rec parse () =
    let input = read_line () in
    let lst = Str.split (Str.regexp " ") input in
    if List.length lst = 0 then
      parse ()
    else
      List.map String.lowercase lst

  let rec confirm () =
    let input = parse () in
    match List.nth input 0 with
    | "y" | "yes" -> true
    | "n" | "no" -> false
    | _ -> confirm ()
end
