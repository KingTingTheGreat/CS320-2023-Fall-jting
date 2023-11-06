#use "./../../../../classlib/OCaml/MyOCaml.ml";;
#use "./../../assign4.ml";;

let list_length(xs: 'a list): int =
  let rec inner xs acc = 
    match xs with
    |x0 :: xs -> inner xs (acc+1)
    |_ -> acc 
  in 
inner xs 0

let fchildren (x0: 'a gtree): 'a gtree list =
  match x0 with
  | GTnil -> [] 
  | GTcons(_, xs) -> xs


  (* let rec gtree_streamize_dfs tree =
    let rec traverse node =
      match node with
      | StrNil -> StrNil
      | StrCons (value, children_thunk) ->
        let children = children_thunk () in
        let child_streams = traverse children in
        StrCons (value, fun () -> child_streams)
    in
    match tree () with
    | StrNil -> StrNil
    | StrCons (_, _) -> traverse tree *)

    let rec gtree_streamize_dfs tree = fun() ->
      match tree with
      |GTnil -> StrNil 
      |GTcons(x0, xs) ->
        list_foreach(xs)(StrNil)(fun acc xss -> stream_foreach(gtree_streamize_dfs) -> StrCons(gtree_streamize_dfs(xss)acc))
      ;;