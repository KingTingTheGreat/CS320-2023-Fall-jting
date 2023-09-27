let rec foreach(i1: int)(i2:int)(work) =
    if i1 < n1 then (
        if i2 < n2  then
            let c1 = string_get_at(cs1)(i1)
            c2 = string_get_at(cs2)(i2) in
            if c1 <= c2 then 
                (work(c1); foreach(i1+1)(i2+0)(work))
            else 
                (work(c2); foreach(i1+0)(i2+1)(work))
        else
            int1_foreach(n1-i1)
                (fun i -> work(string_get_at(cs1)(i1+i)))
            ) 
    else (
        int1_foreach(n2-i2)
            (fun i -> work(string_get_at(cs2)(i2+i)))
        )
        in
        string_make_fwork(foreach(0)(0))
    ;;