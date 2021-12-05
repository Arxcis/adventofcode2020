from functools import reduce
from sys import stdin
import math
import re

def get_stdin():
    return [line.rstrip() for line in stdin]

def loops(pk, sn):
    v = sn
    cnt = 1
    while v != pk:
        v = (v * sn) % 20201227
        cnt += 1
    return cnt

def transform(sn, cnt):
    v = 1
    for i in range(cnt):
        v = (v * sn) % 20201227
    return v

# PART 1

pks=[int(l) for l in get_stdin()]

sizes=[loops(pk,7) for pk in pks]
privates = [transform(pks[(i+1) % 2], sizes[i]) for i in range(2)]

if privates[0] == privates[1]:
    print(privates[0])
else:
    print("Fail:")
    print("loopsizes", sizes)
    print("privates", privates)
