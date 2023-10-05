#use "./../../../../classlib/OCaml/MyOCaml.ml";;
(* #use "./assign3-2.ml";; *)

let list_nchoose(xs: 'a list)(n: int): 'a list list = 
  let rec combine k acc xs =
    (* base case *)
    if k = 0 then [acc]
    else
      match xs with
      | [] -> [] (* nothing else do *)
      | x0 :: xs ->
          list_append (combine (k - 1) (x0 :: acc) xs) (combine k acc xs) (* recurse with current element and without *)
  in
  if n = 0 then [[]] (* the only list with 0 elements *)
  else combine n [] xs
