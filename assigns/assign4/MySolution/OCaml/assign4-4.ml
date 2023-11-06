#use "./../../../../classlib/OCaml/MyOCaml.ml";; 

(** len(xs) **)
let rec list_length(xs: 'a list): int = 
  list_foldleft(xs)(0)(fun acc x0 -> acc + 1)
;;

(** [xs[index]] **)
let rec list_get_at(xs: 'a list)(index: int): 'a list =
  match xs with
  |[] -> []
  |x0::xs -> if index = 0 then [x0] else list_get_at(xs)(index-1)
;;

(** exclusive on the back; xs[:index] **)
let list_get_until(xs: 'a list)(index: int): 'a list = 
  if index <= 0 then [] else 
  let rec inner(xss)(length)(acc) = 
    match xss with 
    |[] -> acc 
    |x0::xss -> if length = 1 then x0::acc  else inner(xss)(length-1)(x0::acc)
  in list_reverse(inner(xs)(index)([]))
;;


(** inclusive on the front; xs[index:] **)
let list_get_from(xs: 'a list)(index: int): 'a list =
  let rec inner(xss)(length)(acc) = 
    match xss with
    |[] -> acc 
    |x0::xss -> 
      if length < index then inner(xss)(length+1)(acc) 
      else inner(xss)(length+1)(x0::acc)
  in list_reverse(inner(xs)(0)([]))
;;

(* 
  let rec list_permute(xs: 'a list): 'a list stream = fun() ->
      match xs with
      |[] -> StrNil
      |x0::xs -> StrCons(x0, StrNil)
    else
      match xs with
      |[] -> StrNil 
      |x0::xss -> 
        stream_foreach(list_permute(xss))(int1_foreach(list_length(xs))(fun index ->
        stream_foreach(list_permute(xss))(int1_foreach(list_length(xs))(fun index ->
let rec permutations result other = function
| [] -> [result]
| hd :: tl ->
  let r = permutations (hd :: result) [] (other @ tl) in
  if tl <> [] then
    r @ permutations result (hd :: other) tl
  else
    r
  ;;
*)

(* let rec permutations result other = fun () ->
  match other with
| [] -> [result]
| hd :: tl ->
  let r = permutations (hd :: result) [] (other @ tl) in
  if tl <> [] then
    r @ permutations result (hd :: other) tl
  else
    r
  ;;

  let list_permute xs = fun(

    permutations [] [] xs;;  *)

let stream_foldleft = 
  foreach_to_foldleft stream_foreach;;

let listize(stream) = 
stream_foldleft(stream)([])(fun acc x0 -> x0 :: acc);;

  let rec list_permute(xs: 'a list): 'a stream = fun() ->
    let perm(s)(e) =
      if list_length s = 0 then e
      else  
        int1_foreach(list_length s)(fun i -> 
          listize(list_permute((list_get_until s i) @ (list_get_from s (i+1))));
          listize(list_permute(e @ list_get_at xs i));
        )
        in perm xs [];;