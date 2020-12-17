from functools import reduce
from sys import stdin
import math

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()

# PART 1

def setmask(line):
    m = line.split(" = ")[1]
    mask = int(0)
    for c in m:
        mask = mask << 1
        if c == "1":
            mask += 1
    #print("setmask", "{0:b}".format(mask))
    return mask

def unsetmask(line):
    m = line.split(" = ")[1]
    #print(m)
    mask = int(0)
    for c in m:
        mask = mask << 1
        if c != "0":
            mask += 1
    #print("unsetmask", "{0:b}".format(mask))
    return mask

def parse(l):
    parts = l.split(" = ")
    value = int(parts[1])
    left = parts[0]
    cmd = left[0:3]
    addr = int(left[4:len(left)-1])
    #print(cmd, addr, value)
    return cmd, addr, value

ormask = setmask(lines[0])
andmask = unsetmask(lines[0])
mem = {}

for l in lines:
    if l[0:4] == "mask":
        ormask = setmask(l)
        andmask = unsetmask(l)
    else:
        cmd, addr, value = parse(l)
        value = value | ormask
        value = value & andmask
        mem[addr] = value

print(sum(mem.values()))


# PART 2

mem = {}

def unsetmask2(m):
    mask = int(0)
    for c in m:
        mask = mask << 1
        if c == "0":
            mask += 1
    #print("unsetmask", "{0:b}".format(mask))
    return mask

def toInt(m):
    i = 0
    for c in m:
        i = i << 1
        if c == "1":
            i += 1
    return i

def makeMasks(m):
    masks = []
    if m.count("X") == 0:
        return toInt(m)
    q = [m]
    while len(q) > 0:
        next = q.pop(0)
        pos = next.find("X")
        if pos < 0:
            masks.append(toInt(next))
        else:
            left = next[0:pos]
            right = next[pos+1:]
            q.append(left+"0"+right) 
            q.append(left+"1"+right)
    return masks     

def combine(mem, lowaddr, value, masks):
    for m in masks:
        mem[lowaddr + m] = value

masks = []

for l in lines:
    if l[0:4] == "mask":
        mask = l.split(" = ")[1]
        masks = makeMasks(mask)
        unset = unsetmask2(mask)
    else:
        cmd, addr, value = parse(l)
        combine(mem, addr & unset, value, masks)

print(sum(mem.values()))
