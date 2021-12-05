from sys import stdin
import math

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()

# PART 1

p = [0, 0]

compass = {
    "N": [0,1],
    "S": [0,-1],
    "E": [1,0],
    "W": [-1,0],
    "F": [1, 0]
}

def add(a, b, arg):
    return [a[0]+b[0]*arg, a[1]+b[1]*arg]

def md(vec):
    return abs(vec[0]) + abs(vec[1])

def rotate(vec, degrees):
    radians = degrees * math.pi / 180.0
    x, y = vec[0] * 1.0, vec[1] * 1.0
    xx = x * math.cos(radians) + y * math.sin(radians)
    yy = -x * math.sin(radians) + y * math.cos(radians)
    res = [round(xx), round(yy)]
    if md(vec) != md(res):
        print("bad!", vec, res)
        exit(1)
    return res

for l in lines:
    cmd = l[0]
    arg = int(l[1:])
    if cmd == "L":
        compass["F"] = rotate(compass["F"], -arg)
    elif cmd == "R":
        compass["F"] = rotate(compass["F"], arg)
    else:
        p = add(p, compass[cmd], arg)

print(md(p))

# PART 2

p = [0, 0]

compass = {
    "N": [0,1],
    "S": [0,-1],
    "E": [1,0],
    "W": [-1,0],
    "F": [10,1]
}

for l in lines:
    cmd = l[0]
    arg = int(l[1:])
    if cmd == "L":
        compass["F"] = rotate(compass["F"], -arg)
    elif cmd == "R":
        compass["F"] = rotate(compass["F"], arg)
    elif cmd == "F":
        p = add(p, compass["F"], arg)
    else:
        compass["F"] = add(compass["F"], compass[cmd], arg)

print(md(p))
