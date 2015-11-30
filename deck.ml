open Card

type deck = card list

exception Empty

let empty = []

let suit_list = [Spades;Hearts;Diamonds;Clubs]
let rank_list = [Two;Three;Four;Five;Six;Seven;Eight;Nine;Ten;Jack;Queen;
                 King;Ace]
let form_pairs lst1 lst2 =
  List.fold_right (fun x acc -> (List.map (fun y -> (x,y)) lst2) @ acc) lst1 []

let new_deck =
  form_pairs suit_list rank_list

let new_double_deck =
  new_deck @ new_deck

let size d =
  List.length d

(* Removes the nth element from this list *)
let rec remove n = function
  | [] -> raise Emptys
  | h::t -> if n = 0 then t else h::(remove (n-1) t)

let draw d =
  let _ = Random.self_init() in
  let n = Random.int (size d) in
  let new_deck = remove n d in
  let drawn_card = List.nth d n in
  (drawn_card,new_deck)