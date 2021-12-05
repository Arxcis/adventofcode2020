from sys import stdin
from copy import deepcopy

if __name__ == '__main__':
    num_steps = 6

    # read input
    lines = stdin.read().split()
    start_slice = [
        [int(lines[l][c] == '#') if 0 <= c < len(lines) else 0 for c in range(-num_steps-1, len(lines[l])+num_steps+1)]
        if 0 <= l < len(lines) else [0] * (len(lines) + num_steps*2 + 2)
        for l in range(-num_steps-1, len(lines) + num_steps+1)
    ]

    # ================================================ PART ONE ================================================
    # intitialization
    puzzle = [[[0]*len(start_slice[0]) for _ in range(len(start_slice))] for _ in range(3 + num_steps * 2)]
    puzzle[len(puzzle)//2] = start_slice

    # Evaluate neighbours
    for step in range(1, num_steps + 1):
        puzzle_ = deepcopy(puzzle)
        for z, slice in enumerate(puzzle[1:-1], start=1):
            for y, row in enumerate(slice[1:-1], start=1):
                for x, active in enumerate(row[1:-1], start=1):
                    neighbours = [act for s in puzzle[z-1:z+2] for r in s[y-1:y+2] for act in r[x-1:x+2]]
                    active_neighbours = sum(neighbours) - active

                    if active:
                        if active_neighbours < 2 or active_neighbours > 3:
                            puzzle_[z][y][x] = 0
                    else:
                        if active_neighbours == 3:
                            puzzle_[z][y][x] = 1
        puzzle = puzzle_

    print(sum([act for s in puzzle for r in s for act in r]))

    # ================================================ PART TWO ================================================
    # Intitialization
    puzzle = [[[[0]*len(start_slice[0]) for _ in range(len(start_slice))] for _ in range(3 + num_steps * 2)] for _ in range(3 + num_steps * 2)]
    puzzle[len(puzzle)//2][len(puzzle[0])//2] = start_slice

    # Evaluate hyperspace neighbours
    for step in range(1, num_steps + 1):
        puzzle_ = deepcopy(puzzle)
        for w, cube in enumerate(puzzle[1:-1], start=1):
            for z, slice in enumerate(cube[1:-1], start=1):
                for y, row in enumerate(slice[1:-1], start=1):
                    for x, active in enumerate(row[1:-1], start=1):
                        ne = [act for c in puzzle[w-1:w+2] for s in c[z-1:z+2] for r in s[y-1:y+2] for act in r[x-1:x+2]]
                        active_neighbours = sum(ne) - active
                        if active:
                            if active_neighbours < 2 or active_neighbours > 3:
                                puzzle_[w][z][y][x] = 0
                        else:
                            if active_neighbours == 3:
                                puzzle_[w][z][y][x] = 1
        puzzle = puzzle_
    print(sum([act for c in puzzle for s in c for r in s for act in r]))
