#use "./../../../../classlib/OCaml/MyOCaml.ml";;

(* attempt to create List.init n (fun i -> i) using MyOCaml functions *)
(* let list n = 
  let accumulator = (int1_foreach n (fun i acc -> i::acc)) [] in 
  list_reverse accumulator *)

let list_of_buddies word =
  let n = string_length word in 
  let buddies = 
    (* foldleft on list of integers from 0 to n-1 *)
    list_foldleft (List.init n (fun i -> i)) []
    (fun acc i ->
      (* get the word around index i *)
      let prefix = String.sub word 0 i in
      let suffix = String.sub word (i + 1) (n - i - 1) in
      (* insert all letters into the ith position *)
      list_foldleft         
      ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l'; 'm'; 'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x'; 'y'; 'z']
      acc 
      (fun acc c ->
          let buddy = string_append(prefix)(string_append(str(c))(suffix)) in
          (* check that we have not recreated the starting word *)
          if buddy <> word then
            buddy :: acc
          else
            acc
        )
    )
  in
  buddies
;;