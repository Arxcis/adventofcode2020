from functools import reduce
from sys import stdin
import math

# Horribly slow, ridiculous, but faster than refac of the moronic 'mem'

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()
numbers = [int(n) for n in lines]


# PART 1 & 2

mem = {}
round = 1
last = -1

def addocc(num, round):
    occs = mem.get(num)
    if occs is None:
        mem[num] = [round]
    else:
        if len(occs) == 1:
            mem[num] = [occs[0], round] # yeah, yeah, pure waste. Refac for New Year. :)
        else:
            mem[num] = [occs[1], round]

for n in numbers:
    addocc(n, round)
    last = n
    round += 1

while round < 30000000+1:
    lastoccs = mem[last]
    if len(lastoccs) < 2:
        addocc(0, round)
        last = 0
    else:
        nextnum = lastoccs[1] - lastoccs[0]
        addocc(nextnum, round)
        last = nextnum
    if round in (2020, 30000000):
        print(last)
    round += 1


