#use "./../../../classlib/OCaml/MyOCaml.ml";;

(*

Please implement the interp function following the
specifications described in CS320_Fall_2023_Project-1.pdf

Notes:
1. You are only allowed to use library functions defined in MyOCaml.ml
   or ones you implement yourself.
2. You may NOT use OCaml standard library functions directly.

*)
(* type digit = 
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9;;

type bool = 
   True | False;;

type const = 
int | bool | Unit;; *)

let (^) = string_append;;

type constant = 
   |Int of int 
   |Bool of bool 
   |Unit 
;;

type com = 
   |Push of constant
   |Pop
   |Trace
   |Add 
   |Sub 
   |Mul
   |Div
   |And 
   |Or 
   |Not 
   |Lt 
   |Gt
;;

let rec intToString(x: int): string =
   if x < 0 then "-" ^ (intToString (x * -1))
   else if x < 10 then str (char_of_digit x)
   else (intToString (x / 10)) ^ (intToString (x mod 10))
;;

let toString(x: constant): string = 
   match x with
   |Unit -> "Unit"
   |Bool b -> if b then "True" else "False"
   |Int i -> intToString i 
;;

let getInt i: int = 
   match i with 
   |Int i -> i 
   |_ -> failwith "Panic"

let add stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         (getInt i) + (getInt j)
;;

let sub stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         (getInt i) - (getInt j)
;;

let mul stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         (getInt i) * (getInt j)
;;

let div stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         if (getInt j) = 0 then failwith "Panic" 
         else (getInt i) / (getInt j)
;;

let getBool b = 
   match b with 
   |Bool b -> b 
   |_ -> failwith "Panic"

let andd stack = 
   match stack with 
   |[] -> failwith "Panic"
   |a :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |b :: stack ->
         (getBool a) && (getBool b)
;;

let orr stack = 
   match stack with 
   |[] -> failwith "Panic"
   |a :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |b :: stack ->
         (getBool a) || (getBool b)
;;

let nott stack = 
   match stack with 
   |[] -> failwith "Panic"
   |a :: stack ->
      not(getBool a)

let lt stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         (getInt i) < (getInt j)
;;

let gt stack = 
   match stack with 
   |[] -> failwith "Panic"
   |i :: stack -> 
      match stack with
      |[] -> failwith "Panic"
      |j :: stack ->
         (getInt i) > (getInt j)       
;;


let rec parse_constant () : constant parser = 
   parse_pos () <|> parse_neg () <|> parse_true () <|> parse_false ()

   and parse_pos () : constant parser =
      let* n = natural in
      pure (Int n) << whitespaces

   and parse_neg () : constant parser = 
      let* _ = keyword "-" in 
      let*n = natural in 
      pure (Int (-1 * n)) << whitespaces

   and parse_true () : constant parser =
      let* _ = keyword "True" in
      pure (Bool true) << whitespaces
   
   and parse_false () : constant parser = 
      let* _ = keyword "False" in 
      pure (Bool false) << whitespaces
   



let rec parse_com () : com parser =
   parse_push () <|> parse_pop () <|> parse_trace () <|> 
   parse_add () <|> parse_sub () <|> parse_mul () <|> 
   parse_div () <|> parse_and () <|> parse_or () <|> 
   parse_not () <|> parse_lt () <|> parse_gt()

   and parse_push () : com parser =
      let* _ = keyword "Push" in
      let* es = parse_constant () in
      let* _ = keyword ";" in
      pure (Push es)

   and parse_pop () : com parser =
      let* _ = keyword "Pop" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Pop)

   and parse_trace () : com parser =
      let* _ = keyword "Trace" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Trace)

   and parse_add () : com parser =
      let* _ = keyword "Add" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Add)

   and parse_sub () : com parser =
      let* _ = keyword "Sub" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Sub)

   and parse_mul () : com parser =
      let* _ = keyword "Mul" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Mul)

   and parse_div () : com parser =
      let* _ = keyword "Div" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Div)

   and parse_and () : com parser =
      let* _ = keyword "And" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (And)

   and parse_or () : com parser =
      let* _ = keyword "Or" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Or)

   and parse_not () : com parser =
      let* _ = keyword "Not" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Not)

   and parse_lt () : com parser =
      let* _ = keyword "Lt" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Lt)

   and parse_gt () : com parser =
      let* _ = keyword "Gt" in
      let* es = many1' parse_com in
      let* _ = keyword ";" in
      pure (Gt)


let interp (s : string)  = (* YOUR CODE *)
   (* let stack = [] in 
   let trace = [] in *)
   (* try string_parse (parse_com ()) s with
   |Some(e, []) -> Some e 
   |_ -> "Panic" :: trace  *)
   match string_parse (parse_com ()) s with 
   |Some(e, []) -> Some e 
   |_ -> None

   (* if s = "" then None 
   else Some(["success"]) *)
;
