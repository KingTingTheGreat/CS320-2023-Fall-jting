#use "./../../assign2.ml";;
#use "./../../../../classlib/OCaml/MyOCaml.ml";;

let string_sepjoin_list(sep:string)(xs:string list): string = 
  let fopr output x = 
    (* first string in list, don't want sep at the beginning of output *)
    if output = "" then x
    (* not the first string, add separator between previous and current*)
    else string_append(output)(string_append(sep)(x))
  in   
  list_foldleft xs "" fopr
