from sys import stdin
from collections import namedtuple
from math import prod

TestCase = namedtuple('TestCase', 'x y')

def get_stdin():
    return [line.rstrip() for line in stdin]

def create_matrix(lines):
    matrix = []
    for line in lines:
        matrix.append([0 if char == "." else 1 for char in line])
    return matrix

matrix = create_matrix([line for line in get_stdin()])

def solve(cases):
    counter = []
    for case in cases:
        position = [0, 0]
        count = 0
        while position[1] < len(matrix) - 1:
            position[0] = (position[0] + case.x) % len(matrix[position[1]])
            position[1] += case.y
            count += matrix[position[1]][position[0]]
        counter.append(count)
    return counter

print(solve([TestCase(3, 1)])[0])

print(prod(solve([
    TestCase(1, 1),
    TestCase(3, 1),
    TestCase(5, 1),
    TestCase(7, 1),
    TestCase(1, 2),
])))

