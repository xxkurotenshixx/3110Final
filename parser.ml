let parse () =
  let input = read_line () in
  String.split (Str.regex " ") input
