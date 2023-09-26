#use "./../../assign2.ml";;

let rec mylist_length(xs:'a mylist): int = 
  match xs with
  |MyNil -> 0
  |MyCons(x1, xs) -> 1 + mylist_length(xs)
  |MySnoc(xs, x1) -> mylist_length(xs) + 1
  |MyReverse(xs) -> mylist_length(xs)
  |MyAppend2(xs1, xs2) -> mylist_length(xs1) + mylist_length(xs2)

let rec mylist_get_at(xs:'a mylist)(i0:int): 'a = 
  if i0 < 0 then mylist_subscript_exn()
  else 
    match xs with
    (* can't index an empty list *)
    |MyNil -> mylist_subscript_exn();
    |MyCons(x1, xs) -> 
      (* check if current element is at the index we're looking for *)
      if i0 = 0 then x1 
      (* recurse if not *)
      else mylist_get_at(xs)(i0-1)
    |MySnoc(xs, x1) -> 
      (* recurse if index in the first section *)
      let len2 = mylist_length(xs) in 
      if len2 < i0 then mylist_get_at(xs)(i0) 
      (* return last element if it's at the index we're looking for *)
      else if len2 = i0 then x1 
      (* raise exception if out of bounds *)
      else mylist_subscript_exn();
    |MyReverse(xs) -> 
      (* recurse but adjust index to account for reversal *)
      let len = mylist_length(xs) in 
      mylist_get_at(xs)(len-i0-1)
    |MyAppend2(xs1, xs2) -> 
      (* check which half the index is in *)
      let len1 = mylist_length(xs1) in 
      if i0 < len1 then mylist_get_at(xs1)(i0) 
      (* this recursive call on the second section will raise an exception if out of bounds *)
      else mylist_get_at(xs2)(i0-len1)
