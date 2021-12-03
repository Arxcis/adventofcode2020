from functools import reduce
from sys import stdin
import math

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()
steps = 6

# saves time on part 2 vs iterating over full cube from round 1
def extendminimamaxima(bounds, x,y,z,w):
    if x < bounds[0][0]:
        bounds[0][0] = x
    if y < bounds[0][1]:
        bounds[0][1] = y
    if z < bounds[0][2]:
        bounds[0][2] = z
    if w < bounds[0][3]:
        bounds[0][3] = w
    if x > bounds[1][0]:
        bounds[1][0] = x
    if y > bounds[1][1]:
        bounds[1][1] = y
    if z > bounds[1][2]:
        bounds[1][2] = z
    if w > bounds[1][3]:
        bounds[1][3] = w
    return bounds

def isactive(grid, x, y, z, w):
    a = grid.get((x,y,z,w))
    return a is not None

def setactive(grid, bounds,x,y,z,w):
    grid[(x,y,z,w)] = True
    return extendminimamaxima(bounds, x,y,z,w)

def setinactive(grid, x,y,z,w):
    grid.popitem((x,y,z,w))

def activeneighbours3d(grid, x,y,z,w):
    activecount = 0
    for x1 in [x-1, x, x+1]:
        for y1 in [y-1, y, y+1]:
            for z1 in [z-1, z, z+1]:
                if x1 != x or y1 != y or z1 != z:
                    if isactive(grid,x1,y1,z1,0):
                        activecount += 1
    return activecount

def nextgrid3d(grid, bounds):
    nextgrid = {}
    for x in range(bounds[0][0]-1, bounds[1][0]+2):
        for y in range(bounds[0][1]-1, bounds[1][1]+2):
            for z in range(bounds[0][2]-1, bounds[1][2]+2):
                neighbours = activeneighbours4d(grid, x, y, z, 0)
                currentlyactive = isactive(grid,x,y,z,0)
                #print("state",x,y,z,currentlyactive,neighbours)
                if currentlyactive and neighbours in [2,3]:
                    bounds = setactive(nextgrid,bounds,x,y,z,0)
                elif not currentlyactive and neighbours == 3:
                    bounds = setactive(nextgrid,bounds,x,y,z,0)
    return nextgrid, bounds

def activeneighbours4d(grid, x,y,z,w):
    activecount = 0
    for x1 in [x-1, x, x+1]:
        for y1 in [y-1, y, y+1]:
            for z1 in [z-1, z, z+1]:
                for w1 in [w-1, w, w+1]:
                    if x1 != x or y1 != y or z1 != z or w1 != w:
                        if isactive(grid,x1,y1,z1,w1):
                            activecount += 1
    return activecount

def nextgrid4d(grid, bounds):
    nextgrid = {}
    for x in range(bounds[0][0]-1, bounds[1][0]+2):
        for y in range(bounds[0][1]-1, bounds[1][1]+2):
            for z in range(bounds[0][2]-1, bounds[1][2]+2):
                for w in range(bounds[0][3]-1, bounds[1][3]+2):
                    neighbours = activeneighbours4d(grid, x, y, z, w)
                    currentlyactive = isactive(grid,x,y,z,w)
                    #print("state",x,y,z,currentlyactive,neighbours)
                    if currentlyactive and neighbours in [2,3]:
                        bounds = setactive(nextgrid,bounds,x,y,z,w)
                    elif not currentlyactive and neighbours == 3:
                        bounds = setactive(nextgrid,bounds,x,y,z,w)
    return nextgrid, bounds

def parseInput(lines):
    bignum = 2000000000
    minima = [bignum, bignum, bignum, bignum]
    maxima = [-bignum, -bignum, -bignum, -bignum]
    bbox = [minima, maxima]
    grid = {}
    for y in range(len(lines)):
        for x in range(len(lines[0])):
            if lines[y][x] == "#":
                bbox = setactive(grid, bbox, x, y, 0, 0)
    return grid, bbox

def part1(lines):
    startgrid, bbox = parseInput(lines)
    stepgrid = startgrid.copy()
    for i in range(0,steps):
        stepgrid, bbox = nextgrid3d(stepgrid, bbox)
    print(len(stepgrid))

def part2(lines):
    startgrid, bbox = parseInput(lines)
    stepgrid = startgrid.copy()
    for i in range(0,steps):
        stepgrid, bbox = nextgrid4d(stepgrid, bbox)
    print(len(stepgrid))


part1(lines)
part2(lines)
