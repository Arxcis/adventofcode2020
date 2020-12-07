#from functools import reduce
from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

max = -1
seats = [0 for i in range(8*128)] 

for line in get_stdin():
    pos = 0
    dy = 64 * 8
    row = 0
    for ychar in line[:7]:
        if ychar == "B":
            pos += dy
        dy = dy // 2
    dx = 4
    for xchar in line[7:]:
        if xchar == "R":
            pos += dx
        dx = dx // 2
    seats[pos] = 1
    if pos > max:
        max = pos

print(max)

for i in range(8*128):
    if seats[i] == 1 and seats[i+1] == 0 and seats[i+2] == 1:
        print(i+1)

