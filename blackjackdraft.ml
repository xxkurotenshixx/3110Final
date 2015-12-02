module Dealer = struct
open Deck
open Card


let card_val c hand=
  let (s,r) = c in
  match r with
  | Two -> 2
  | Three -> 3
  | Four -> 4
  | Five -> 5
  | Six -> 6
  | Seven -> 7
  | Eight -> 8
  | Nine -> 9
  | Ten -> 10
  | Jack -> 10
  | Queen -> 10
  | King -> 10
  | Ace ->  let without_aces = Bjupdater.remove_cards hand c in
            let conv_val = List.map (fun x -> card_val x) without_aces in
            let val_without = List.fold_left (fun x y -> x + y) 0 conv_val in
            if (val_without + 11) <= 21
            then 11
            else 1


let sum hand =
  let conv_val = List.map (fun x -> card_val x) hand in
  List.fold_left (fun x y -> x + y) 0 conv_val


let compare_sum ph dh =
  let psum = sum ph in
  match (compare psum dh) with
  | 1 -> Bjprinter.game_won ()
  | 0 -> Bjprinter.game_tie ()
  | -1 -> Bjprinter.game_lost ()

(*gotta deal with soft 17 later aka when hand of 17 with Ace counted as 11*)
let dealer_move hand =
  let _ = Bjprinter.print_hand hand in
  match sum hand with
  | x with (x = 21) -> if ph = 21 then Bjprinter.game_tie () else Bjprinter.game_lost ()
  | y with (y < 17) -> Printf.printf "The dealer chooses to hit."; hit y
  | z with (z > 17) -> Printf.printf "The dealer chooses to stand."; compare_sum ph z

let player_check hand dh =
  match (sum hand) with
  | x with (x > 21) -> Bjprinter.game_lost ()
  | y with (y = 21) -> dealer_move dh
  | _ -> Bjprinter.print_hand hand


let rec player_move input ph dh =
  match input with
  | "hit" -> let new_hand = hit ph in player_check new_hand
  | "stand" -> dealer_move dh

let hit hand =

let run









end