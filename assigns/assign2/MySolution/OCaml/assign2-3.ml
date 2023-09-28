#use "./../../assign2.ml";;
#use "./../../../../classlib/OCaml/MyOCaml.ml";;


let foldleft_to_iforeach (foldleft: ('xs, 'x0, int) foldleft): ('xs, 'x0) iforeach =
  let rec wrapper index xs =
    match xs with
    | [] -> ()
    | x :: xs ->
    (index, x); (* index and element *)
    wrapper (index + 1) xs (* recurse to next *)
  in
  fun xs -> 
    match xs with
    | [] -> () (* Handle an empty list case *)
    | _ -> foldleft xs 0 wrapper