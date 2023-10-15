#use "./../../../../classlib/OCaml/MyOCaml.ml";;

let the_ln2_stream: float stream = fun() ->
  let rec streamize(denom:float)(acc:float)(sign:float): 'a stream =
    fun() -> 
    (* next number in the sequence *)
    let nextNum:float = sign /. denom in 
    (* add it to the running total *)
    let nextSum:float = acc +. nextNum in 
    (* flip sign every time *)
    StrCons(nextSum, streamize(denom +. 1.)(nextSum)(sign *. -1.))
  in 
  (* start with 1, recurse *)
  StrCons(1., streamize(2.)(1.)(-1.) )