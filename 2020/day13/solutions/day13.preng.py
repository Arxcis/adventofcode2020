from functools import reduce
from sys import stdin
import math

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()

# PART 1

earliest = int(lines[0])
buses = [int(n) for n in lines[1].split(",") if n != "x"]

now = False
t = earliest
while not now:
    for bus in buses:
        if t % bus == 0:
            #print("success at", t, "with", bus)
            print((t-earliest) * bus)
            now = True
    t += 1


# PART 2

def busno(num):
    if num == "x":
        return -1
    else:
        return int(num)

# Googled modulo equations and the Chinese theorem. Not fully understanding why this works.
def mul_inv(a, b):
    b0 = b
    x0, x1 = 0, 1
    if b == 1: return 1
    while a > 1:
        q = a // b
        a, b = b, a%b
        x0, x1 = x1 - q * x0, x0
    if x1 < 0: x1 += b0
    return x1

def chinese_remainder(n, a):
    sum = 0
    prod = reduce(lambda a, b: a*b, n)
    for n_i, a_i in zip(n, a):
        p = prod // n_i
        sum += a_i * mul_inv(p, n_i) * p
    return sum % prod

def find_earliest(buses):
    modulos = [n for n in buses if n != -1]
    deltas = []
    for i in range(len(buses)):
        if buses[i] != -1:
            deltas.append(-i)
    #print(modulos, deltas)
    return(chinese_remainder(modulos, deltas))

tests = [
    [-1,-1,3,5],
    [7,13,-1,-1,59,-1,31,19],
    [17,-1,13,19],
    [67,7,59,61],
    [67,-1,7,59,61],
    [67,7,-1,59,61],
    [1789,37,47,1889]
]

# for t in tests:
#     print(find_earliest(t), t)
#     print("")
# exit(0)

buses = [busno(n) for n in lines[1].split(",")]

#print(buses, len(buses))
print(find_earliest(buses))
