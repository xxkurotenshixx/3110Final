let rec parse () =
  Printf.printf " >> ";
  let input = read_line () in
  let lst = Str.split (Str.regexp " ") input in
  if List.length lst = 0 then
    parse ()
  else
    List.filter (fun x -> x <> "") (List.map String.lowercase lst)

let rec confirm () =
  let input = parse () in
  match List.nth input 0 with
  | "y" | "yes" -> true
  | "n" | "no" -> false
  | _ -> confirm ()
