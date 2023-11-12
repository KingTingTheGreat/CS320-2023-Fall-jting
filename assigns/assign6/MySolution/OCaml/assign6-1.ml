#use "./../../assign6.ml";;
#use "./../../../../classlib/OCaml/MyOCaml.ml";;

(* coverts an int to it's corresponding string *)
let int_to_string(x0: int): string = 
  str (char_of_digit x0)
;;

(* takes in a sexpr and returns a string representation *)
let rec sexpr_to_string(x0: sexpr): string = 
  match x0 with 
  |SAdd exprs -> string_append "(add" (string_append (sexpr_parse_list exprs) ")")
  |SMul exprs -> string_append "(mul" (string_append (sexpr_parse_list exprs) ")")
  |SInt i -> int_to_string i

  and 

  (* takes in a list of sexprs and returns a string representation *)
  sexpr_parse_list(xs: sexpr list): string = 
    (* items in list are always preceeded by a space *)
    match xs with
    |[] -> ""
    |x0::xs -> string_append " " (string_append (sexpr_parse_expr x0) (sexpr_parse_list xs))
;;

let sexpr_parse(s: string): sexpr option = Some(SAdd [SInt 1; SInt 2]);;
