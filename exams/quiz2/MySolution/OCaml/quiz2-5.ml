(* ************************************************ *)

(*
Q2-5: 5 points
The function list_last returns the last element of a given
list. Please give a NON-RECURSIVE implementation of list_last
based on pattern matching and list_foldright. If the given list
is empty, raise the Empty exception
*)

(* ************************************************ *)

#use "./../../../../classlib/OCaml/MyOCaml.ml";;

exception Empty
(** original implementation: **)
let list_last(xs: 'a list): 'a = 
  list_foldright xs (()) (fun last x0 ->
    match x0 with 
    |() -> if last = () then raise Empty else last 
    |_ -> if last = () then x0 else last)
  (** incorrect usage of unit, "()" **)
  (** should compare the output of of list_foldright xs (()) fun, not the inputs of fun **)