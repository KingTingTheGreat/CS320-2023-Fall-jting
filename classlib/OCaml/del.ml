#use "./MyOCaml.ml";;


let
mystream =
let
rec
fstream(n: int): int stream = fun() ->
StrCons(n, stream_map(fstream(n+1))(fun(x) -> x+x+1)) in
fstream(0)
;;



let list_length xs = list_foldleft(xs)(0)(fun acc x0 -> acc + 1);;

(* let rec list_get_at xs index = 
  match xs with 
  |x0::xs -> if index = 0 then x0 else list_get_at xs (index-1) 
  |_ -> failwith "failed";; *)

let list_get_at xs index = 
  let (_, res) = list_foldleft(xs)(0, None)(fun (i, acc) x0 -> if i = index then (i+1, x0) else (i+1, acc)) in 
  match res with
  |Some(x) -> x 
  |None -> failwith "out of bounds"
;;

let pascals = fun() ->
  let rec gen_next(prev) = fun() ->
    let temp = int1_foldleft((list_length prev)-1)([1])(fun acc i -> (((list_get_at prev i) + (list_get_at prev (i+1))) :: acc)) 
  in let next = 1 :: temp in
  StrCons(next, gen_next(next)) 
in 
let first_row = [1] in
StrCons(first_row, gen_next(first_row));;

let rec nth_stream strm n = 
  if n = 0 then [] 
  else 
    match strm() with 
    |StrNil -> [] 
    |StrCons(x0, xs) -> x0 :: nth_stream strm (n-1);;

    let rec stream_take n st =
      if n = 0 then []
      else
        match st () with
        | StrNil -> []
        | StrCons (x, xs) -> x :: stream_take (n - 1) xs;;