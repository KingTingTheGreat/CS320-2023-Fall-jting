#use "./../../../../classlib/OCaml/MyOCaml.ml";;
#use "./../../assign5.ml";;

let parse input =
  let chars = string_listize input in 
  let rec iter seq args = 
    let seq = trim seq in 
    match seq with 
    |[] -> ""
    |'('::seq -> iter seq 1
    |')'::seq -> iter seq 1
    |'a'::'d'::'d'::seq -> iter seq 2
    |'m'::'u'::'l'::seq -> iter seq 2
    |_ -> iter seq 0
  iter input 0
  ;;  