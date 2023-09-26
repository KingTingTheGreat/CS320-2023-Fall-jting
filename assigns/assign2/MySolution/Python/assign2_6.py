import sys 
sys.path.append("./../../../../classlib/Python")
from MyPython import *
from assign2_5 import *

def string_length(cs:str) -> int:
    return len(cs)   

def string_get_at(cs:str, i:int) -> str:
    return cs[i]

def string_make_fwork(fwork) -> str:
    xs:fnlist = fnlist_make_fwork(fwork)
    return ''.join(xs)

def string_merge(cs1:str, cs2:str) -> str:
    n1:int = string_length(cs1)
    n2:int = string_length(cs2)
    def foreach(i1:int=0, i2:int=0, work=lambda c: c) -> None:
        if i1 < n1:
            if i2 < n2:
                c1, c2 = string_get_at(cs1, i1), string_get_at(cs2, i2)
                if c1 <= c2:
                    work(c1)
                    foreach(i1+1, i2, work)
                else:
                    work(c2)
                    foreach(i1, i2+1, work)
            else:
                int1_foreach(n1-i1, lambda i: work(string_get_at(cs1, i1+i)))
        else:
            int1_foreach(n2-i2, lambda i: work(string_get_at(cs2, i2+i)))
    return string_make_fwork(foreach)

