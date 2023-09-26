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

