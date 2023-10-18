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


# # faster implementation of the above algorithm
# solved = {}  # hashtable to prevent recalculating the same result
# def cubedRoot(x):
#     """ returns cubed root of num or None if no such int exists """
#     root = solved.get(x, -1)  # -1 allows us to store None in the table
#     if root != -1:
#         return root
#     root = int(round(x ** (1/3)))
#     root = root if (root ** 3 == x) else None
#     # store this result
#     solved[x] = root
#     return root

# def cubesum_pairs(total):
#     """ generator for all pairs whose cube sum is total """
#     for i in range(total//2 + 1):  # ensure x < y
#         j = total - i
#         x = cubedRoot(i)
#         if x is None:
#             continue
#         y = cubedRoot(j)
#         if y is None:
#             continue
#         yield (x, y)

def getCubes():
    """ a generator of cubes """
    n = 0
    while True:
        yield n ** 3
        n += 1

def cubedRoot(n):
    """ returns the cube root of n """
    return int(round(n ** (1/3)))

def theNatPairs_cubesum():
    """ enuermates all pairs of natural numbers """
    total = 0
    while True:
        i_gen = getCubes()
        i = next(i_gen)
        while i <= total // 2:
            j_gen = getCubes()
            j = next(j_gen)
            while True:
                if i + j > total:
                    break
                if i + j == total:
                    yield(cubedRoot(i), cubedRoot(j))
                j = next(j_gen)
            i = next(i_gen)
        total += 1