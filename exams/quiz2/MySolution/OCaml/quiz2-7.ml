#use "./../../../../classlib/OCaml/MyOCaml.ml";;



(* ************************************************ *)

(*
Q2-7: 10 points

The following implementation of list_append is not tail-recursive.
Please give an implementation of list_append that is tail-recursive.

Note that you can only use pattern matching and list_foldleft in your
implementation.
 
let rec
list_append(xs: 'a list)(ys: 'a list) =
match xs with
  [] -> ys | x1 :: xs -> x1 :: list_append(xs)(ys)
*)

(* ************************************************ *)
let list_reverse(xs: 'a list): 'a list =
  list_foldleft(xs)([])(fun acc x1 -> x1 :: acc)
;;

let list_add(xs)(y0) =
  list_foldleft(list_reverse xs)([y0])(fun acc x1 -> x1::acc)
;;

let rec list_append(xs: 'a list)(ys: 'a list): 'a list = 
  match ys with
  |[] -> xs 
  |y0::ys -> list_append(list_add(xs)(y0))(ys)
;;
