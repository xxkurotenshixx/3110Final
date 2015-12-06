open Deck

let choose_random (hand: Card.card list) =
  let _ = Random.self_init() in
  let n = Random.int (List.length hand) in
  snd (List.nth hand n)

let rec ai_decide hand ranklist =
  match hand with
  | (player, rank)::t ->
    if List.mem rank ranklist then Some rank else ai_decide t ranklist
  | [] -> None



