#use "./../../../../classlib/OCaml/MyOCaml.ml";;

type board_t = int * int * int * int * int * int * int * int

let queen8_puzzle_solve(b: board_t): board_t list = 
  []