#use "./../../assign2.ml";;
#use "./../../../../classlib/OCaml/MyOCaml.ml";;

(* let foldleft_to_iforeach(foldleft:('xs, 'x0, int) foldleft): ('xs, 'x0) iforeach = 
  let fun(xs)(work) -> let _ = foldleft(xs)(fun(x0) -> (work(x0))) in ();;

  let rec wrapper(acc: unit)(x: 'x0): unit =
    wrapper acc x;
    ()
  in foldleft xs () wrapper
  
  fun xs callback -> 
    let rec wrapper index xs' =
      match xs' with
      |[] -> ()
      |x::xs'' ->
        callback index x;
        wrapper (index+1) xs''
      in
      (* foldleft xs 0 wrapper *)
      match xs with 
      |[] -> ()
      |_ -> foldleft xs 0 wrapper *)

let foldleft_to_iforeach (foldleft: ('xs, 'x0, int) foldleft): ('xs, 'x0) iforeach =
  fun xs callback ->
    let rec callback_wrapper xs index =
      match xs with
      | [] -> ()
      | x :: xs ->
        callback index x; (* Call the provided callback with the index and element *)
        callback_wrapper xs (index + 1)
    in

    match xs with
    | [] -> () (* Handle an empty list case *)
    | _ -> foldleft xs 0 callback_wrapper
      

      