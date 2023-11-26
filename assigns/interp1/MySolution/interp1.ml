#use "./../../../classlib/OCaml/MyOCaml.ml";;

(*

Please implement the interp function following the
specifications described in CS320_Fall_2023_Project-1.pdf

Notes:
1. You are only allowed to use library functions defined in MyOCaml.ml
   or ones you implement yourself.
2. You may NOT use OCaml standard library functions directly.

*)

let (^) = string_append;;


(* type digit = 
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9;;

type bool = 
   True | False;;

type const = 
int | bool | Unit;; *)


type stackTypes = 
   |Int of int
   |Bool of bool
   |Unit
;;

let rec intToString(x: int): string =
   if x < 0 then "-" ^ (intToString (x * -1))
   else if x < 10 then str (char_of_digit x)
   else (intToString (x / 10)) ^ (intToString (x mod 10))
;;

let toString x: string = 
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

let interp (s : string) : string list option = (* YOUR CODE *)
   if s = "" then None 
   else Some(["success"])
;
