(*used to represent card suits*)
type suit = Spades | Diamonds | Hearts | Clubs
(*used to represent card rank*)
type rank = Two | Three | Four | Five | Six | Seven | Eight | Nine |
            Ten | Jack | Queen | King | Ace
(*a card represented by a suit and a rank*)
type card = suit * rank

let card_to_int c =
  let (_,r) = c in
  match r with
  | Two   -> 2
  | Three -> 3
  | Four  -> 4
  | Five  -> 5
  | Six   -> 6
  | Seven -> 7
  | Eight -> 8
  | Nine  -> 9
  | Ten   -> 10
  | Jack  -> 11
  | Queen -> 12
  | King  -> 13
  | Ace   -> 1

let int_to_rank = function
  | 1 -> Ace
  | 2 -> Two
  | 3 -> Three
  | 4 -> Four
  | 5 -> Five
  | 6 -> Six
  | 7 -> Seven
  | 8 -> Eight
  | 9 -> Nine
  | 10 -> Ten
  | 11 -> Jack
  | 12 -> Queen
  | 13 -> King
  | _ -> failwith "not a valid rank int"

let string_to_rank = function
  | "two"   -> Two
  | "three" -> Three
  | "four"  -> Four
  | "five"  -> Five
  | "six"   -> Six
  | "seven" -> Seven
  | "eight" -> Eight
  | "nine"  -> Nine
  | "ten"   -> Ten
  | "jack"  -> Jack
  | "queen" -> Queen
  | "king"  -> King
  | "ace"   -> Ace
  | _ -> failwith "not a valid rank string"

let rank_string = function
  | Two   -> "Two"
  | Three -> "Three"
  | Four  -> "Four"
  | Five  -> "Five"
  | Six   -> "Six"
  | Seven -> "Seven"
  | Eight -> "Eight"
  | Nine  -> "Nine"
  | Ten   -> "Ten"
  | Jack  -> "Jack"
  | Queen -> "Queen"
  | King  -> "King"
  | Ace   -> "Ace"

let suit_string = function
  | Spades   -> "Spades"
  | Diamonds -> "Diamonds"
  | Hearts   -> "Hearts"
  | Clubs    -> "Clubs"

let card_to_string c =
  let s,r = c in
  rank_string r ^ " of " ^ suit_string s

let string_to_suit = function
  | "spades" -> Spades
  | "diamonds" -> Diamonds
  | "clubs" -> Clubs
  | "hearts" -> Hearts
  | _ -> failwith "not a valid input"

let string_to_card s =
  try
    let sl = Str.split (Str.regexp ",") s in
    let s = string_to_suit (List.nth sl 0) in
    let r = int_to_rank (int_of_string (List.nth sl 1)) in
    (s,r)
  with
  | _ -> failwith "invalid card"

let int_to_str n = match n with
  | 1 -> "Ace"
  | 2 -> "Two"
  | 3 -> "Three"
  | 4 -> "Four"
  | 5 -> "Five"
  | 6 -> "Six"
  | 7 -> "Seven"
  | 8 -> "Eight"
  | 9 -> "Nine"
  | 10 -> "Ten"
  | 11 -> "Jack"
  | 12 -> "Queen"
  | _ -> "King"

let same_number c1 c2 =
  let _,r1 = c1 in
  let _,r2 = c2 in
  r1 = r2

let same_card c1 c2 = c1 = c2
