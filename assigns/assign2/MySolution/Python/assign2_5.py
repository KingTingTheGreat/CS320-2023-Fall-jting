import sys
sys.path.append("./../../../../classlib/Python")
from MyPython import *

def fnlist_make_fwork(fwork) -> fnlist:
    # initialize result list
    res:fnlist = fnlist_nil()
    # define internal work function
    def work(x0):
        nonlocal res
        # append to result
        res = fnlist_cons(x0, res)
    # call the above defined work function
    fwork(work)
    # return reversed result
    return fnlist_reverse(res)
