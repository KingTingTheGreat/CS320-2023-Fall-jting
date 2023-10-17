
def int1_foreach(n0, work_func):
    i0 = 0
    while(i0 < n0):
        work_func(i0)
        i0 = (i0 + 1)
    return None # work_func(i0) is done for all 0 <= i0 < n0

def string_tabulate(n, func) -> str:
    """ returns the string of length n by the func function """
    return ''.join([func(i) for i in range(n)])

def string_fset_at(cs: str, i0:int, c0:str) -> str:
    """ returns cs with the character at i0 replaced with c0 """
    return string_tabulate(len(cs), lambda i: cs[i] if i != i0 else c0)

def list_make_fwork(fwork) -> list[any]:
    """ returns the list created by the fwork function """
    res = []
    def work(x0):
        nonlocal res
        res.append(x0)
    fwork(work)
    return res

def string_foreach(cs: str, work) -> str:
    """ performs the work function on each character of cs """
    return int1_foreach(len(cs), lambda i0: work(cs[i0]))

def alphabet() -> str:
    """ returns the lowercase letters of the alphabet """
    return string_tabulate(26, lambda inc: chr(ord('a')+inc))

def list_of_buddies(word:str) -> list[str]:
    """ returns all buddies of input str word """
    return list_make_fwork(lambda work: int1_foreach(len(word), lambda i0: string_foreach(alphabet(), lambda c1: work(string_fset_at(word, i0, c1)) if c1 != word[i0] else None)))

# # more straight forward python implementation
# def string_fset_at(cs: str, i0:int, c0:str) -> str:
#     """ returns the string cs with the character at index i0 replace with c0 """
#     return ''.join([c0 if i == i0 else cs[i] for i in range(len(cs))])

# def alphabet() -> str:
#     """ returns a string of all lowercase letters in alphabetical order """
#     return ''.join([chr(ord('a')+x) for x in range(26)])


# def list_of_buddies(word: str) -> list[str]:
#     """ returns all buddies of input word """
#     return [
#         string_fset_at(word, i, c) for c in alphabet()  # create buddy for each letter at this index
#         for i in range(len(word))  # iterate through indices of word
#         if c != word[i]  # ensure we are not including original word
#         ]