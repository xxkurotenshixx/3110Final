open Card

type deck = card list

exception Empty

let empty = []

let new_deck =
  [(Spades,Two);(Spades,Three);(Spades,Four);(Spades,Five);(Spades,Six);
   (Spades,Seven);(Spades,Eight);(Spades,Nine);(Spades,Ten);(Spades,Jack);
   (Spades,Queen);(Spades,King);(Spades,Ace);
   (Hearts,Two);(Hearts,Three);(Hearts,Four);(Hearts,Five);(Hearts,Six);
   (Hearts,Seven);(Hearts,Eight);(Hearts,Nine);(Hearts,Ten);(Hearts,Jack);
   (Hearts,Queen);(Hearts,King);(Hearts,Ace);
   (Diamonds,Two);(Diamonds,Three);(Diamonds,Four);(Diamonds,Five);
   (Diamonds,Six);(Diamonds,Seven);(Diamonds,Eight);(Diamonds,Nine);
   (Diamonds,Ten);(Diamonds,Jack);(Diamonds,Queen);(Diamonds,King);
   (Diamonds,Ace);
   (Clubs,Two);(Clubs,Three);(Clubs,Four);(Clubs,Five);(Clubs,Six);
   (Clubs,Seven);(Clubs,Eight);(Clubs,Nine);(Clubs,Ten);(Clubs,Jack);
   (Clubs,Queen);(Clubs,King);(Clubs,Ace)]

let new_double_deck =
  new_deck @ new_deck

let size d =
  List.length d

(* Removes the nth element from this list *)
let rec remove n = function
  | [] -> raise Empty
  | h::t -> if n = 0 then t else h::(remove (n-1) t)

let draw d =
  let n = Random.int (size d) in
  let new_deck = remove n d in
  let drawn_card = List.nth d n in
  (drawn_card,new_deck)
