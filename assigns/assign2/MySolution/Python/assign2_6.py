import sys 
sys.path.append("./../../../../classlib/Python")
from MyPython import *
from assign2_5 import *

def string_length(cs:str) -> int:
    """ returns the length of input string """
    return len(cs)   

def string_get_at(cs:str, i:int) -> str:
    """ returns the character at index i in string cs """
    assert (i < len(cs)) if i >= 0 else ((-1*i) <= len(cs))
    return cs[i]

def string_make_fwork(fwork) -> str:
    """ returns a string made from characters processed by fwork """
    xs:fnlist = fnlist_make_fwork(fwork)
    return ''.join(xs)

def string_merge(cs1:str, cs2:str) -> str:
    """ returns the merged result of two sorted strings in ascending order """
    # initialize variables to the lengths of each string
    n1:int = string_length(cs1)
    n2:int = string_length(cs2)
    def foreach(i1:int=0, i2:int=0, work=lambda c: c) -> None:
        """ processes each character of the output string """
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

