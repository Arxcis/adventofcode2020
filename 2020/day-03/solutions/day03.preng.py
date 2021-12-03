#from functools import reduce
from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

def treesCount(lines, deltax, deltay):
    rows = len(lines)
    cols = len(lines[0])
    #print("dim", rows, cols)
    y = 0
    x = 0
    trees = 0
    while y < rows:
        #print("checking", y, x, lines[y][x % cols])
        if lines[y][x % cols] == "#":
            trees += 1
        x += deltax
        y += deltay
    return trees

grid = [l for l in get_stdin()]

#print(grid)

print(treesCount(grid, 3, 1))

one = treesCount(grid, 1, 1)
three = treesCount(grid, 3, 1)
five = treesCount(grid, 5, 1)
seven = treesCount(grid, 7, 1)
onetwo = treesCount(grid, 1, 2)

#print("1-1:", one)
#print("3-1:", three)
#print("5-1:", five)
#print("7-1:", seven)
#print("1-2:", onetwo)
print(one * three * five * seven * onetwo)


