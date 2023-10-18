def getCubes():
    """ a generator of cubes """
    n = 0
    while True:
        yield(n, n**3)
        n += 1
        
cubes = {}
# cubes = {}  # hashtable to prevent recalculating the same result
def cubedRoot(x):
    """ returns cubed root of num or None if no such int exists """
    root = cubes.get(x, -1)  # -1 allows us to store None in the table
    if root != -1:
        return root
    root = int(round(x ** (1/3)))
    root = root if (root ** 3 == x) else None
    # store this result
    cubes[x] = root
    return root

def theNatPairs_cubesum():
    """ enuermates all pairs of natural numbers """
    total = 0
    while True:
        # try all i up until (i+i > total) since i <= j
        i_gen = getCubes()
        root_i, i = next(i_gen)
        while i + i <= total:
            # for a given i, there is only one possible j
            j = total - i
            if i > j:
                break
            j = cubedRoot(j)
            # j = cubes.get(j, None)
            if j is not None:
                yield (root_i, j)
            root_i, i = next(i_gen)
        total += 1

# from time import perf_counter
# ct = 0
# s = perf_counter()
# for i, j in theNatPairs_cubesum():
#     if (i**3)+(j**3) < 1000000:
#         ct += 1
#     else:
#         break
# e = perf_counter()
# print(ct)
# print(e-s)
