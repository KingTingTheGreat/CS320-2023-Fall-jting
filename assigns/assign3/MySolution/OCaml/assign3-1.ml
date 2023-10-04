#use "./../../../../classlib/OCaml/MyOCaml.ml";;

(** returns the element at index index in list xs **)
let rec get_at_index(xs: 'a list)(index: int): 'a = 
  match xs with
  |[] -> failwith "Index out of bounds"
  |x0::xs -> if index = 0 then x0 else get_at_index(xs)(index-1)

(** returns a list of elements that are at index n of each of the lists in list of list xss **)
let get_nth_col(xss: 'a list list)(n: int): 'a list =
  list_foldleft(xss)([])(fun acc xs -> (get_at_index xs n) :: acc)



  (* let col = [] in

  in 
  let rec iter(xss: 'a list list) =
    match xss with 
    | [] -> ()
    | xs :: xss -> get_at xs :: col; iter xss
in iter xss

let rec matrix_transpose(xss: 'a list list): 'a list list = 
  let trans = [[]] in 

  get_nth_col xss 0 *)