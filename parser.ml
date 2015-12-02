module Parser =
  struct
  let rec parse () =
    let input = read_line () in
    let lst = Str.split (Str.regexp " ") input in
    if List.length lst = 0 then
      parse ()
    else
      List.map String.lowercase lst
  end
