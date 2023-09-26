#use "./../../assign2.ml";;

let rec mylist_length(xs:'a mylist): int = 
  match xs with
  (* empty list has no length *)
  |MyNil -> 0
  (* take away the single unit and recurse on the rest *)
  |MyCons(x1, xs) -> 1 + mylist_length(xs)
  |MySnoc(xs, x1) -> mylist_length(xs) + 1
  (* reversed list has the same length *)
  |MyReverse(xs) -> mylist_length(xs)
  (* sum of length of front and back *)
  |MyAppend2(xs1, xs2) -> mylist_length(xs1) + mylist_length(xs2)


(* tail recursive implementation of mylist_length *)
let mylist_length_tail(xs: 'a mylist): int = 
  let rec tail_rec(xs:'a mylist)(acc:int): int = 
    match xs with
    (* an empty list has no length *)
    |MyNil -> acc
    (* add to accumulator and recurse *)
    |MyCons(x1, xs) -> tail_rec xs (acc+1)
    |MySnoc(xs, x1) -> tail_rec xs (acc+1)
    (* reversed list has same length *)
    |MyReverse(xs) -> tail_rec xs acc
    (* only add accumulator to one of the recurisve calls *)
    |MyAppend2(xs1, xs2) -> (tail_rec xs1 acc) + (tail_rec xs2 0)
  in tail_rec xs 0