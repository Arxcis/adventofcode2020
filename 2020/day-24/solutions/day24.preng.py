from functools import reduce
from sys import stdin
import math
import re

# dev tip:
# watchman-make -p 'io/*.input' 'solutions/*.py' --run "cat io/preng.input | /usr/local/opt/python@3.8/bin/python3.8 solutions/day24.preng.py"

def get_stdin():
    return [line.rstrip() for line in stdin]

#
#             -1,1  0,1  1,1
#         -1,0   0,0   1,0
#            -1,-1  0,-1  1,-1
#
# "nwwswee"

evendeltas = {
    "e": (1,0),
    "se": (0,-1),
    "sw": (-1,-1),
    "w": (-1,0),
    "nw": (-1,1),
    "ne": (0,1),
}

odddeltas = {
    "e": (1,0),
    "se": (1,-1),
    "sw": (0,-1),
    "w": (-1,0),
    "nw": (0,1),
    "ne": (1,1),
}

def coord(line):
    global deltas
    x = 0
    y = 0
    while len(line) > 0:
        direction = line[0]
        line = line[1:]
        if direction in ["n", "s"]:
            direction += line[0]
            line = line[1:]
        if (y % 2) == 1:
            move = odddeltas[direction]
        else:
            move = evendeltas[direction]
        x += move[0]
        y += move[1]
    return x, y

def testcoord():
    if coord("esew") != (0, -1):
        print("coord fail for esew", coord("esew"))
    pos = coord("nwwswee")
    if pos != (0, 0):
        print("coord fail for nwwswee", pos)

def flip(grid, path):
    pos = coord(path)
    if pos in grid:
        grid[pos] = False # white
    else:
        grid[pos] = True # black
    return grid

def blackneighbours(grid, pos):
    cnt = 0
    if (pos[1] % 2) == 1:
        deltas = odddeltas
    else:
        deltas = evendeltas            
    for dpos in deltas.values():
        testpos = (pos[0]+dpos[0], pos[1]+dpos[1])
        if testpos in grid and grid[testpos]:
            cnt += 1
    return cnt

def copyandgrow(grid):
    ng = {}
    for pos, v in grid.items():
        ng[pos] = v
        if v: # black, fill missing whites around it so grid can grow
            if (pos[1] % 2) == 1:
                deltas = odddeltas
            else:
                deltas = evendeltas            
            for dpos in deltas.values():
                testpos = (pos[0]+dpos[0], pos[1]+dpos[1])
                if not testpos in grid:
                    ng[testpos] = False
    return ng

def mutate(grid):
    ng = copyandgrow(grid)
    for pos, black in ng.items():
        bnc = blackneighbours(grid, pos)
        if black and (bnc == 0 or bnc > 2):
            ng[pos] = False
        elif not black and bnc == 2:
            ng[pos] = True
    return ng


# PART 1

testcoord()
lines = get_stdin()
grid = {}
for l in lines:
    grid = flip(grid, l)
print(len([b for b in grid.values() if b]))

# PART 2
# grid for part 1 is day zero
for i in range(100):
    grid = mutate(grid)
print(len([b for b in grid.values() if b]))




