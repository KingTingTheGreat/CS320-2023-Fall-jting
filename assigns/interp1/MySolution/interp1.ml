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

(* let getInt i: int = 
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
;; *)

let andd(a: bool)(b: bool): bool = 
   if a then 
      if b then true 
      else false 
   else false
;;

let orr(a: bool)(b: bool): bool = 
   if a then 
      true 
   else if b then 
      true 
   else false
;;

let nott(a: bool): bool = 
   if a then false else true 
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
      let* c = parse_constant () in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Push c)

   and parse_pop () : com parser =
      let* _ = keyword "Pop" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Pop)

   and parse_trace () : com parser =
      let* _ = keyword "Trace" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in *)
      pure (Trace)

   and parse_add () : com parser =
      let* _ = keyword "Add" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Add)

   and parse_sub () : com parser =
      let* _ = keyword "Sub" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Sub)

   and parse_mul () : com parser =
      let* _ = keyword "Mul" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Mul)

   and parse_div () : com parser =
      let* _ = keyword "Div" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Div)

   and parse_and () : com parser =
      let* _ = keyword "And" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (And)

   and parse_or () : com parser =
      let* _ = keyword "Or" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Or)

   and parse_not () : com parser =
      let* _ = keyword "Not" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Not)

   and parse_lt () : com parser =
      let* _ = keyword "Lt" in
      let* _ = keyword ";" in
      (* let* res = many1' parse_com in  *)
      pure (Lt)

   and parse_gt () : com parser =
      let* _ = keyword "Gt" in
      let* _ = keyword ";" in 
      (* let* res = many1' parse_com in  *)
      pure (Gt)


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

let trim_string(cs: string): string = 
   list_foldleft (trim_list (string_listize cs)) "" (fun acc c -> string_snoc acc c)
;;


let rec parse_input(s: string): com list option = 
   let s = trim_string s in 
   if s = "" then Some([]) else
   match string_parse(parse_com ()) s with 
   |None -> None
   |Some(e, []) -> Some([e])
   |Some(e, rest) -> 
      let res = parse_input(list_foldleft(rest)("")(fun acc c -> string_snoc acc c)) in 
      match res with 
      |Some(r) -> Some(e::r)
      |None -> None
   (* |Some(e, rest) -> Some (e :: (parse_com () rest)) *)
   (* |_ -> None *)
;;

let rec compute(coms: com list)(stack: constant list)(trace: string list): string list = 
   (* ["good job"] *)
   match coms with 
   |[] -> trace
   |com::coms ->
      match com with 
      |Push c -> compute coms (c::stack) trace
      |Pop -> 
         (match stack with 
         |c::stack -> compute coms stack trace
         |_ -> "Panic"::trace)
      |Trace ->
         (match stack with
         |c::stack -> compute coms (Unit::stack) (toString(c)::trace)
         |_ -> "Panic"::trace)
      |Add ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> compute coms (Int(i+j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Sub ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> compute coms (Int(i-j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Mul ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> compute coms (Int(i*j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Div ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> if j = 0 then "Panic"::trace else compute coms (Int(i/j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |And ->
         (match stack with 
         |a::b::stack -> 
            (match a with 
            |Bool a -> 
               (match b with 
               |Bool b -> compute coms (Bool(andd a b)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Or ->
         (match stack with 
         |a::b::stack -> 
            (match a with 
            |Bool a -> 
               (match b with 
               |Bool b -> compute coms (Bool(orr a b)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Lt ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> compute coms (Bool(i<j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Gt ->
         (match stack with 
         |i::j::stack -> 
            (match i with 
            |Int i -> 
               (match j with 
               |Int j -> compute coms (Bool(i>j)::stack) trace 
               |_ -> "Panic"::trace) 
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Not ->
         (match stack with 
         |a::stack -> 
            (match a with 
            |Bool a -> compute coms (Bool(nott a)::stack) trace
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
;;

let interp (s : string)  = (* YOUR CODE *)
   (* let stack = [] in  *)
   (* let trace = [] in *)
   (* try string_parse (parse_com ()) s with
   |Some(e, []) -> Some e 
   |_ -> "Panic" :: trace  *)
   match parse_input(s) with 
   |None -> None 
   |Some(coms) -> 
      Some(compute(coms)([])([]))
;;

   (* 
   fold left on stack   
   *)

