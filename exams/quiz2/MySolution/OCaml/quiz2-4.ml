(* ************************************************ *)

(*
Q2-4: 5 points
The function list_last returns the last element of a given
list. Please give a NON-RECURSIVE implementation of list_last
based on pattern matching and list_foldleft. If the given list
is empty, raise the Empty exception
*)

(* ************************************************ *)

#use "./../../../../classlib/OCaml/MyOCaml.ml";;

exception Empty
(** original implementation: **)
let list_last(xs: 'a list): 'a = 
  let last = list_foldleft xs (()) (fun prev x0 ->
    match prev with 
    |() -> x0 
    |_ -> x0)
  in if last = () then raise Empty else last
  (** this does not work because of an incorrect usage of unit, "()" **)