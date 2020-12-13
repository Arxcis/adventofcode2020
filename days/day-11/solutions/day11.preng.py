from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()
maxx = len(lines[0])
maxy = len(lines)
pt2lines = [[c for c in line] for line in lines]

# PART 1

def neighbors(y, x):
    occ = 0
    if x > 0 and y > 0 and lines[y-1][x-1] == "#":
        occ += 1
    if y > 0 and lines[y-1][x] == "#":
        occ += 1
    if x < maxx-1 and y > 0 and lines[y-1][x+1] == "#":
        occ += 1
    if x < maxx-1 and lines[y][x+1] == "#":
        occ += 1
    if x < maxx-1 and y < maxy-1 and lines[y+1][x+1] == "#":
        occ += 1
    if y < maxy-1 and lines[y+1][x] == "#":
        occ += 1
    if x > 0 and y < maxy-1 and lines[y+1][x-1] == "#":
        occ += 1
    if x > 0 and lines[y][x-1] == "#":
        occ += 1
    return occ

def run(runlines, neighborFunc, acceptancy):
    changed = 0
    tmp = [[c for c in line] for line in runlines]
    for y in range(maxy):
        for x in range(maxx):
            occ = neighborFunc(y, x) 
            if runlines[y][x] == "L" and occ == 0:
                tmp[y][x] = "#"
                changed += 1
            elif runlines[y][x] == "#" and occ >= acceptancy:
                tmp[y][x] = "L"
                changed += 1
    return tmp, changed

def debug(lines):
    for line in lines:
        print(line)
    print("")

iterations = 0
changed = 1
while changed > 0:
    lines, changed = run(lines, neighbors, 4)
    iterations += 1
    #debug(lines)

#print(iterations)
sum = 0
for line in lines:
    sum += line.count("#")
print(sum)


# PART 2
#print("part2")

def seeocc(y, x, dy, dx):
    ty = y + dy
    tx = x + dx
    if ty > -1 and ty < maxy and tx > -1 and tx < maxx:
        if pt2lines[ty][tx] == "#":
            return 1
        elif pt2lines[ty][tx] == "L":
            return 0
        else:
            return seeocc(ty, tx, dy, dx)
    else:
        return 0

def neighbor2(y, x):
    occ = 0
    for dy in range(-1, 2):
        for dx in range(-1, 2):
            if not (dy == 0 and dx == 0):
                occ += seeocc(y, x, dy, dx)
    return occ


iterations = 0
changed = 1
while changed > 0:
    pt2lines, changed = run(pt2lines, neighbor2, 5)
    iterations += 1
    #debug(pt2lines)

#print(iterations)
sum = 0
for line in pt2lines:
    sum += line.count("#")
print(sum)
