#use "./../../../../classlib/OCaml/MyOCaml.ml";;

let theNatPairs: (int*int) stream = fun() -> 
  let rec nxt((i, j)) = fun() ->
    (* increment i and decrement j *)
    if j <> 0 then
      StrCons((i, j), nxt(i+1, j-1))
    (* finished with pairs that sum to i, create pairs that sum to i + 1 *)
    else 
      StrCons((i, j), nxt(0, i+1))
  in 
  (* start with 0, next is from 1 *)
  StrCons((0, 0), nxt(0, 1))