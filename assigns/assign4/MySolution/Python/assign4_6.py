# def cubedRoot(num: int) -> int:
#     """ returns cubed root of num or None if no such int exists """
#     n = 0
#     while True:
#         cubed = n * n * n
#         if cubed == num:
#             return n
#         if cubed > num:
#             return None 
#         n += 1


# faster implementation of the above algorithm
solved = {}  # hashtable to prevent recalculating the same result
def cubedRoot(x):
    """ returns cubed root of num or None if no such int exists """
    root = solved.get(x, -1)  # -1 allows us to store None in the table
    if root != -1:
        return root
    root = int(round(x ** (1/3)))
    root = root if (root ** 3 == x) else None
    # store this result
    solved[x] = root
    return root

def cubesum_pairs(total):
    """ generator for all pairs whose cube sum is total """
    for i in range(total//2 + 1):  # ensure x < y
        j = total - i
        x = cubedRoot(i)
        if x is None:
            continue
        y = cubedRoot(j)
        if y is None:
            continue
        yield (x, y)

def theNatPairs_cubesum():
    """ enuermates all pairs of natural numbers """
    total = 0
    while True:
        for pair in cubesum_pairs(total):
            yield pair
        total += 1