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
    |x0::xs -> string_append " " (string_append (sexpr_to_string x0) (sexpr_parse_list xs))
;;


let string_build(cs: char list): string =
  list_foldleft(cs) "" (fun acc c -> string_snoc acc c);;

let trim(cs: string) = 
  match whitespaces (string_listize cs) with
  (* |Some(xs) -> list_foldleft(xs) "" (fun acc c -> string_snoc acc c) *)
  |Some(cs) -> Some((fun (u, xs) -> xs) cs)
  |_ -> Some(['n'; 'o'; 'n'; 'e'])
;;


(* remove blank chars at the front of a list *)
let rec trim_list(cs: char list): char list =
  match cs with
  | [] -> cs
  | '\n' :: cs -> trim_list cs
  | '\t' :: cs -> trim_list cs
  | '\r' :: cs -> trim_list cs
  | ' ' :: cs -> trim_list cs
  | _ -> cs
;;


let trim_string_to_list(cs: string): char list = 
  trim_list (string_listize cs)
;;

(* let test = 
  keyword "add" (string_listize "add 1 2 ")

let f = 
  match test with 
  Some((x, y)) -> y 
  |_ -> ['a']


let match_add(cs: char list): char list = 
  let expr = keyword "add" cs in
;;

  let match_mul(cs: char list): char list = 
  untuple(keyword "mul" cs)
;; *)

(* let parse_some(x: 'a option): 'a = 
  match x with 
  |Some(b) -> b

let parse_add(cs: char list) = 
  let expr = keyword "add" cs in 
  match expr with 
  |Some(cs) -> Some(cs) 
  |None -> None 
;;

let parse_mul(cs: char list) = 
  let expr = keyword "add" cs in 
  match expr with 
  |Some(cs) -> Some(cs) 
  |None -> None 
;;

let parse_int(cs: char list) = 
  match natural cs with
  |Some(i) -> Some(i) 
  |None -> None
;;

let rec parse_inner(cs: char list): sexpr list = 
  let cs = trim_list cs in 
  match cs with 
  |[] -> []
  |c :: css -> 
    if c = '(' then (parse_sexpr_op css) :: parse_inner css else None
  |_ -> 
    let i = natural cs in 
    match i with 
    |Some((j, css)) -> j :: parse_inner(css)
    |_ -> None

let parse_sexpr_op(cs: char list) = 
  let a = parse_add(cs) in 
  match a with 
  |Some(cs) -> Some(SAdd (parseinner cs))
  |None -> None
    (* let m = parse_mul(cs) in 
    match m with 
    |Some(cs) -> Some(cs) 
    |None -> None *)


let temp(s: string) = 
    let cs = trim_string_to_list s in 
    match cs with
    |c::css -> 
      if c = '(' then parse_sexpr_op (trim_list css)
      else 
        let i = natural cs in 
        match i with 
        |Some((j, css)) -> Some(((), css)) 
        |None -> None
    |_ -> None

let test = temp "  (add 1 2 )";;

let test = temp "1322";;

let test = parse_some test;;

let expr = keyword "add" (string_listize "add ")
(* let test =  *)

let sexpr_parse(s: string): sexpr option = 
  Some(SAdd [SInt 1; SInt 2])
;; *)


(* from lab adjusted to work with sexpr type *)
let rec parse_sexpr () : sexpr parser =
  parse_int () <|> parse_add () <|> parse_mul ()

and parse_int () : sexpr parser =
  let* n = natural in
  pure (SInt n) << whitespaces

and parse_add () : sexpr parser =
  let* _ = keyword "(add" in
  let* es = many1' parse_sexpr in
  let* _ = keyword ")" in
  pure (SAdd es)

and parse_mul () : sexpr parser =
  let* _ = keyword "(mul" in
  let* es = many1' parse_sexpr in
  let* _ = keyword ")" in
  pure (SMul es)

let sexpr_parse (s : string) : sexpr option =
  match string_parse (parse_sexpr ()) s with
  | Some (e, []) -> Some e
  | _ -> None
