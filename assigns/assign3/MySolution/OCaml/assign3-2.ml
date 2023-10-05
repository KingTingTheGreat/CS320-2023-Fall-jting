#use "./../../../../classlib/OCaml/MyOCaml.ml";;

let list_map(xs) = foreach_to_map_list(list_foreach)(xs)


let list_subsets(xs: 'a list): 'a list list =
  let rec generate_subsets remaining current acc =
    match remaining with
    | [] -> current :: acc (* nothing else to do *)
    | x :: xs ->
      (* add current element to subset *)
      let subset = x :: current in
      (* generate subset with current *)
      let subsets_with_x = generate_subsets xs subset acc in
      (* generate subsets without current *)
      let all_subsets = generate_subsets xs current subsets_with_x in
      all_subsets
  in
  generate_subsets xs [] []