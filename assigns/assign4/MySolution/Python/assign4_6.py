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

def getCubes():
    """ a generator of cubes """
    n = 0
    while True:
        yield n ** 3
        n += 1

def theNatPairs_cubesum():
    """ enuermates all pairs of natural numbers """
    total = 0
    while True:
        # try all i up until i+i > total since i <= j
        i_gen = getCubes()
        i = next(i_gen)
        while i + i <= total:
            # for a given i, there is only one possible j
            j = total - i
            j = cubedRoot(j)
            if j is not None:
                yield (cubedRoot(i), j)
            i = next(i_gen)
        total += 1