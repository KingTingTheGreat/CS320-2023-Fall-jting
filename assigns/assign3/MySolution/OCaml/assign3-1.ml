#use "./../../../../classlib/OCaml/MyOCaml.ml";;

(** returns the element at index index in list xs **)
let rec get_at_index(xs: 'a list)(index: int): 'a = 
  match xs with
  |[] -> failwith "Index out of bounds"
  |x0::xs -> if index = 0 then x0 else get_at_index(xs)(index-1)

(** returns the length of list xs **)
let list_length(xs: 'a list): int = 
  let rec inner(xs: 'a list)(acc) =
    match xs with
    |[] -> acc
    |x0::xs -> inner xs (acc+1)
  in inner(xs)(0)

(** returns the size of the first list in list of list xss **)
let inner_size(xss: 'a list list): int = 
  match xss with
  |[] -> 0
  |xs::xss -> list_length xs

(** returns a list of elements that are at index n of each of the lists in list of list xss **)
let get_nth_col(xss: 'a list list)(n: int): 'a list =
  list_reverse(list_foldleft(xss)([])(fun acc xs -> (get_at_index xs n)::acc))

(** returns the transpose of matrix xss **)
let matrix_transpose(xss: 'a list list): 'a list list = 
  list_reverse(int1_foldleft(inner_size xss)([])(fun acc i -> (get_nth_col xss i) :: acc))