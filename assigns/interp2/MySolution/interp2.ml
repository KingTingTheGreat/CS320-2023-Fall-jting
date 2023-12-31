#use "./../../../classlib/OCaml/MyOCaml.ml";;

(*

Please implement the interp function following the
specifications described in CS320_Fall_2023_Project-2.pdf

Notes:
1. You are only allowed to use library functions defined in MyOCaml.ml
   or ones you implement yourself.
2. You may NOT use OCaml standard library functions directly.

*)

(* defining types *)
type constant = 
   |Int of int 
   |Bool of bool 
   |Unit 
;;

type symbol = string;;

type value = 
   |Constant of constant 
   |Symbol of symbol
   |Closure of closure

and 
   closure = symbol * (string list * value list) * com list
   (* {
      name: symbol;
      varenv: string list * value list;
      coms: com list
   } *)
and
   com = 
      |Push of value |Pop |Trace |Add 
      |Sub |Mul |Div |And |Or |Not 
      |Lt |Gt |Swap |IfElse of com list list
      |Bind |Lookup |Fun of com list
      |Call |Return 
;;

(* returns string representation of an integer *)
let rec intToString(x: int): string =
   if x < 0 then string_append "-" (intToString (x * -1))
   else if x < 10 then str (char_of_digit x)
   else string_append (intToString (x / 10)) (intToString (x mod 10))
;;

(* returns string presentations of a constant *)
let constantToString(x: constant): string = 
   match x with
   |Unit -> "Unit"
   |Bool b -> if b then "True" else "False"
   |Int i -> intToString i 
;;

let toString(x: value): string = 
   match x with 
   |Constant x -> constantToString x 
   |Symbol x -> x
   |Closure c -> 
      match c with 
      |(name, varenv, coms) -> string_append (string_append "Fun<" name) ">"
;;

(* defining boolean operators *)
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

(* parse constants *)
let rec parse_constant () : value parser = 
   parse_pos () <|> parse_neg () <|> parse_true () <|> parse_false () <|> parse_unit ()

   and parse_pos () : value parser =
      let* n = natural in
      pure (Constant(Int n)) << whitespaces

   and parse_neg () : value parser = 
      let* _ = keyword "-" in 
      let* n = natural in 
      pure (Constant(Int (-1 * n))) << whitespaces

   and parse_true () : value parser =
      let* _ = keyword "True" in
      pure (Constant(Bool true)) << whitespaces
   
   and parse_false () : value parser = 
      let* _ = keyword "False" in 
      pure (Constant(Bool false)) << whitespaces

   and parse_unit () : value parser = 
      let* _ = keyword "Unit" in 
      pure (Constant(Unit)) << whitespaces
;;

let (&&) = andd;;

let (||) = orr;;

let (!!) = nott;;

let (++) = list_append;;

let alphanum = 
   (satisfy char_isdigit) <|> (satisfy char_islower) <|> (satisfy char_isupper)

let str : string parser =
  fun ls ->
  let@ (xs, ls) = many1 alphanum ls in
  Some(list_foldleft(xs)("") (fun acc c -> string_snoc acc c), ls)
;;

let rec parse_symbol () : value parser = 
   let* s = str in 
   pure (Symbol s) << whitespaces
;;

let parse_value () : value parser = 
   parse_constant () <|> parse_symbol ()
;;


(* parse coms *)
let rec parse_com () : com parser =
   parse_push () <|> parse_pop () <|> parse_trace () <|> 
   parse_add () <|> parse_sub () <|> parse_mul () <|> 
   parse_div () <|> parse_and () <|> parse_or () <|> 
   parse_not () <|> parse_lt () <|> parse_gt() <|>
   parse_swap () <|> parse_ifelse () <|> parse_bind () <|>
   parse_lookup () <|> parse_fun () <|> parse_call () <|>
   parse_return ()

   and parse_push () : com parser =
      let* _ = keyword "Push" in
      let* c = parse_value () in
      pure (Push c)

   and parse_pop () : com parser =
      let* _ = keyword "Pop" in
      pure (Pop)

   and parse_trace () : com parser =
      let* _ = keyword "Trace" in
      pure (Trace)

   and parse_add () : com parser =
      let* _ = keyword "Add" in
      pure (Add)

   and parse_sub () : com parser =
      let* _ = keyword "Sub" in
      pure (Sub)

   and parse_mul () : com parser =
      let* _ = keyword "Mul" in
      pure (Mul)

   and parse_div () : com parser =
      let* _ = keyword "Div" in
      pure (Div)

   and parse_and () : com parser =
      let* _ = keyword "And" in
      pure (And)

   and parse_or () : com parser =
      let* _ = keyword "Or" in
      pure (Or)

   and parse_not () : com parser =
      let* _ = keyword "Not" in
      pure (Not)

   and parse_lt () : com parser =
      let* _ = keyword "Lt" in
      pure (Lt)

   and parse_gt () : com parser =
      let* _ = keyword "Gt" in
      pure (Gt)

   and parse_swap () : com parser = 
      let* _ = keyword "Swap" in 
      pure (Swap)

   and parse_ifelse () : com parser = 
      let* _ = keyword "If" in 
      let* c1 = parse_coms () in 
      let* _ = keyword "Else" in 
      let* c2 = parse_coms () in
      let* _ = keyword "End" in 
      pure (IfElse [c1; c2])

   and parse_bind () : com parser = 
      let* _ = keyword "Bind" in 
      pure (Bind)

   and parse_lookup () : com parser = 
      let* _ = keyword "Lookup" in 
      pure (Lookup)

   and parse_fun () : com parser = 
      let* _ = keyword "Fun" in 
      let* cs = parse_coms () in
      let* _ = keyword "End" in 
      pure (Fun cs)

   and parse_call () : com parser = 
      let* _ = keyword "Call" in 
      pure (Call)

   and parse_return () : com parser = 
      let* _ = keyword "Return" in 
      pure (Return)

   and parse_coms() = 
      many (parse_com () << keyword ";");;

let rec valueOf(x:string)(varenv: string list * value list): value option = 
   match varenv with 
   |(var::vars, v::vals) -> 
      if var = x then Some(v) 
      else (valueOf x (vars, vals))
   |_ -> None
;;

let rec compute(coms: com list)(stack: value list)(trace: string list)(varenv: string list * value list): string list = 
   match coms with 
   |[] -> trace (* base case *)
   |com::coms -> (* recursive case; more coms to process *)
      match com with 
      |Push c -> compute coms (c::stack) trace varenv
      |Pop -> 
         (match stack with 
         |c::stack -> compute coms stack trace varenv
         |_ -> "Panic"::trace)
      |Trace ->
         (match stack with
         |c::stack -> compute coms (Constant(Unit)::stack) (toString(c)::trace) varenv
         |_ -> "Panic"::trace)
      |Add ->
         (match stack with 
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant (Int(i+j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Sub ->
         (match stack with 
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant (Int(i-j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Mul ->
         (match stack with 
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant (Int(i*j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Div ->
         (match stack with 
         |Constant Int i::Constant Int 0::stack -> 
            "Panic"::trace
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant (Int(i/j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |And ->
         (match stack with 
         |Constant Bool a::Constant Bool b::stack -> 
            compute coms (Constant(Bool(a && b))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Or ->
         (match stack with 
         |Constant Bool a::Constant Bool b::stack -> 
            compute coms (Constant(Bool(a || b))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Not ->
         (match stack with 
         |Constant Bool a::stack -> 
            compute coms (Constant(Bool(!! a))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Lt ->
         (match stack with 
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant(Bool(i<j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Gt ->
         (match stack with 
         |Constant Int i::Constant Int j::stack -> 
            compute coms (Constant(Bool(i>j))::stack) trace varenv
         |_ -> "Panic"::trace)
      |Swap -> 
         (match stack with 
         |c1::c2::stack -> compute coms (c2::c1::stack) trace varenv
         |_ -> "Panic"::trace)
      |IfElse cs -> 
         (match stack with 
         |Constant Bool b::stack -> 
            (match cs with 
            |c1::c2::[] -> 
               if b then compute (c1++coms) stack trace varenv 
               else compute (c2++coms) stack trace varenv
            |_ -> "Panic"::trace)
         |_ -> "Panic"::trace)
      |Bind -> 
         (match stack with 
         |Symbol x::v::stack -> 
            (match varenv with 
            |(vars, vals) -> compute coms stack trace ((x::vars), (v::vals)))
         |_ -> "Panic"::trace)
      |Lookup -> 
         (match stack with 
         |x::stack -> 
            (match x with 
            |Symbol x -> 
               (match valueOf x varenv with 
               |Some v -> compute coms (v::stack) trace varenv
               |None -> "Panic - not found"::trace)
            |_ -> (string_append "Panic - not a symbol" (toString(x)))::trace)
         |_ -> "Panic - empty stack"::trace)
      |Fun cs -> 
         (match stack with 
         |Symbol x :: stack -> compute coms (Closure (x, varenv, cs)::stack) trace varenv
         |_ -> "Panic"::trace)
      |Call ->
         (match stack with
         |Closure c :: a :: stack -> 
            (match c with 
            |(cname, cvarenv, ccoms) ->
               (match (cvarenv, varenv) with 
               |(cvars, cvals), (vars, vals) -> 
                  compute ccoms (a::Closure ("cc", varenv, coms)::stack) trace (cname::cvars, Closure c::cvals)))
         |_ -> "Panic"::trace)
      |Return -> 
         (match stack with 
         |Closure (ccname, (cvars, cvals), ccoms) :: a :: stack -> 
            (match varenv with 
            |(vars, vals) -> compute ccoms (a::stack) trace (cvars, cvals))
         |_ -> "Panic"::trace)
;;


let interp (s : string) : string list option  = (* YOUR CODE *)
   (*
   parse input to create a list of commands; return None if parsing fails
   otherwise, perform the commands   
   *)
   match string_parse (whitespaces >> parse_coms ()) s with
   |Some(coms, []) -> Some(compute coms [] [] ([], []))
   |_ -> None
;;

(* ------------------------------------------------------------ *)

(* interp from file *)
(* copied from interp1 solution *)

let read_file (fname : string) : string =
   let fp = open_in fname in
   let s = string_make_fwork (fun work ->
       try
         while true do
           work (input_char fp)
         done
       with _ -> ())
   in
   close_in fp; s
 
 let interp_file (fname : string) : string list option =
   let src = read_file fname in
   interp src
 
