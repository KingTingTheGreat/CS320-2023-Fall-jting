import sys
sys.path.append("./../../../../classlib/Python")
from MyPython import *

def fnlist_make_fwork(fwork) -> list:
    # initialize result list
    res = []
    # define internal work function
    def work(x0):
        # append to result
        res.append(x0)
    # call the above defined work function
    fwork(work)
    # return result
    return res