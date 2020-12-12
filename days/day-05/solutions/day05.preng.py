#from functools import reduce
from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

max = -1
seats = [0 for i in range(8*128)] 

for line in get_stdin():
    pos = 0
    delta = 8 * 64
    row = 0
    for char in line:
        if char in ("B", "R"):
            pos += delta
        delta = delta // 2
    seats[pos] = 1
    if pos > max:
        max = pos

print(max)

for i in range(8*128):
    if seats[i] == 1 and seats[i+1] == 0 and seats[i+2] == 1:
        print(i+1)

