module Bsupdater = struct
type state = {p1 : Card List; p2 : Card List; p3 : Card List; p4 : Card List;
              c : Card List; cp : int; cn : int}

let new_game deck =
  let is_aces c = Card.card_to_string c = "Ace of Spades" in
  let rec dealer d s n =
    if n = 0 then s
    else
      let (cd, nd) = Deck.draw d in
      let ns = match n mod 4 with
        | 0 -> if is_aces cd
               then {s with cp = 1; p1 = cd::s.p1}
               else {s with p1 = cd::s.p1}
        | 1 -> if is_aces cd
               then {s with cp = 2; p2 = cd::s.p2}
               else {s with p2 = cd::s.p2}
        | 2 -> if is_aces cd
               then {s with cp = 3; p3 = cd::s.p3}
               else {s with p3 = cd::s.p3}
        | _ -> if is_aces cd
               then {s with cp = 4; p4 = cd::s.p4}
               else {s with p4 = cd::s.p4} in
      dealer nd ns (n-1) in
  let cs = {p1 = []; p2 = []; p3 = []; p4 = []; c = []; cp = 0; cn = 1} in
  dealer deck cs 52

let remove_cards h cl =
  List.filter (fun x -> List.exists (Card.same_card x) cl) h

let check_bs s cl nc tc p =
  let c = (Spades, tc) in
  if List.for_all (Card.same_number c) cl && List.length cl = nc
  then
    let ns = match p with
      | 1 -> {s with p1 = s.p1 @ cl @ s.c}
      | 2 -> {s with p2 = s.p2 @ cl @ s.c}
      | 3 -> {s with p3 = s.p3 @ cl @ s.c}
      | _ -> {s with p4 = s.p4 @ cl @ s.c} in
    let ns1 = match s.cp with
      | 1 -> {ns with p1 = remove_cards s.p1 cl}
      | 2 -> {ns with p2 = remove_cards s.p2 cl}
      | 3 -> {ns with p3 = remove_cards s.p3 cl}
      | _ -> {ns with p4 = remove_cards s.p4 cl} in
    let fns = {ns1 with c = []; cp = if s.cp = 4 then 1 else s.cp + 1} in
    (false, fns)
  else
    let ns = match s.cp with
      | 1 -> {s with c = []; p1 = s.p1 @ s.c}
      | 2 -> {s wiih c = []; p2 = s.p2 @ s.c}
      | 3 -> {s with c = []; p3 = s.p3 @ s.c}
      | _ -> {s with c = []; p4 = s.p4 @ s.c} in
    (true, ns)

let no_bs cl s =
  match s.cp with
  | 1 -> {s with c = cl @ s.c; p1 = remove_cards s.p1 cl}
  | 2 -> {s with c = cl @ s.c; p2 = remove_cards s.p2 cl}
  | 3 -> {s with c = cl @ s.c; p3 = remove_cards s.p3 cl}
  | _ -> {s with c = cl @ s.c; p4 = remove_cards s.p4 cl}

end
