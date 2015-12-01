let parse () =
  let input = read_line () in
  let lst = Str.split (Str.regexp " ") input in
  List.map String.lowercase lst
