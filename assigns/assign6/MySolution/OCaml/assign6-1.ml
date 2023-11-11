#use "./../../assign6.ml";;
#use "./../../../../classlib/OCaml/MyOCaml.ml";;

let sint_to_string(x0: int): string = 
  string_append " " (str (char_of_digit x0))
;;

let rec sexpr_list_to_string(xs: sexpr list): string = 
  match xs with
  |[] -> ""
  |x0 :: xs ->
    match x0 with
    |SInt i -> string_append (sint_to_string i) (sexpr_list_to_string xs) 
    |_ -> ""

let sexpr_op_to_string(x0: sexpr): string = 
  match x0 with
  |SAdd exprs -> string_append "(add" (string_append (sexpr_list_to_string exprs) ")")
  |SMul exprs -> string_append "(mul" (string_append (sexpr_list_to_string exprs) ")")
  |_ -> ""

let sexpr_to_string(e: sexpr): string = 
  sexpr_op_to_string(e)
;;

let sexpr_parse(s: string): sexpr option = Some(SAdd [SInt 1; SInt 2]);;
