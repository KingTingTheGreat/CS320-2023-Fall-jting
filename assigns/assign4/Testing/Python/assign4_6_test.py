####################################################
#!/usr/bin/env python3
####################################################
import sys
####################################################
sys.path.append('./../../MySolution/Python')
sys.path.append("./../../../../classlib/Python")
####################################################
from MyPython import *
from assign4_6 import *
####################################################
def cube_sum(ij):
    i = ij[0]
    j = ij[1]
    return i*i*i + j*j*j
####################################################
def theNatPairs_count(N):
    res = 0
    for ij in theNatPairs_cubesum():
        if cube_sum(ij) < N:
            res += 1
        else:
            break
        if res % 100 == 0:
            print(res)
    return res
####################################################
assert(theNatPairs_count(1000) == 51)
print('passed test 1')
assert(theNatPairs_count(10000) == 226)
print('passed test 2')

assert(theNatPairs_count(100000) == 995)
print('passed test 3')

assert(theNatPairs_count(1000000) == 4497)
print('passed test 4')

assert(theNatPairs_count(10000000) == 20696)
print('passed test 5')

####################################################
print("Assign4-6-test passed!")
####################################################
