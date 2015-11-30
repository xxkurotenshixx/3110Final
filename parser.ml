let parse () =
  let input = read_line () in
  Str.split (Str.regexp " ") input
