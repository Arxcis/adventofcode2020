from itertools import count
from copy import deepcopy
def charge(data, x, y, width, height):
    if data[y][x] >= 10:
        return
    data[y][x] += 1
    if data[y][x] == 10:
        neighbours = [(x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
                      (x - 1, y), (x + 1, y),
                      (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)]
        for nx, ny in neighbours:
            if 0 <= nx < width and 0 <= ny < height:
                charge(data, nx, ny, width, height)


if __name__ == '__main__':
    input_data = [[int(p) for p in line.strip()] for line in open(0).readlines()]
    width, height = len(input_data[0]), len(input_data)

    # Part 1
    data = deepcopy(input_data)
    flashes = 0
    for step in range(100):
        for y, row in enumerate(data):
            for x, col in enumerate(row):
                charge(data, x, y, width, height)
        for y, row in enumerate(data):
            for x, col in enumerate(row):
                if data[y][x] > 9:
                    data[y][x] = 0
                    flashes += 1
    print(flashes)

    # Part 2
    data = deepcopy(input_data)
    for step in count(start=1):
        for y, row in enumerate(data):
            for x, col in enumerate(row):
                charge(data, x, y, width, height)
        for y, row in enumerate(data):
            for x, col in enumerate(row):
                if data[y][x] > 9:
                    data[y][x] = 0
        if not any(any(row) for row in data):
            print(step)
            break
