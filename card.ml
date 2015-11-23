(*used to represent card suits*)
type suit = Spades | Diamonds | Hearts | Clubs
(*used to represent card rank*)
type rank = Two | Three | Four | Five | Six | Seven | Eight | Nine |
            Ten | Jack | Queen | King | Ace
(*a card represented by a suit and a rank*)
type card = suit * rank
let card_to_string c =
  let s,r = c in
  let rank_string =
    match r with
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
    | Ace   -> "Ace" in
  let suit_string =
    match s with
    | Spades   -> "Spades"
    | Diamonds -> "Diamonds"
    | Hearts   -> "Hearts"
    | Clubs    -> "Clubs" in
  rank_string ^ " of " ^ suit_string

let same_number c1 c2 =
  let _,r1 = c1 in
  let _,r2 = c2 in
  r1 = r2
