import fileinput
import itertools as it
from copy import deepcopy


def valid(row, col):
    return 0 <= row < ROWS and 0 <= col < COLUMNS


def neighborhood_direct(r=0, c=0):
    return [(r - 1, c - 1), (r - 1, c + 1), (r, c - 1), (r + 1, c),
            (r + 1, c + 1), (r + 1, c - 1), (r, c + 1), (r - 1, c)]


def neighborhood_indirect(row, col):
    n = []
    for delta_r, delta_c in neighborhood_direct():
        for step_size in it.count(1):
            r = row + step_size * delta_r
            c = col + step_size * delta_c
            if valid(r, c):
                if board[r][c] != '.':
                    n.append((r, c))
                    break
            else:
                break
    return n

if __name__ == '__main__':
    starting_board = [[c for c in l] for l in fileinput.input()]
    ROWS, COLUMNS = len(starting_board), len(starting_board[0])

    for neighborhood, max_adj in [(neighborhood_direct, 4), (neighborhood_indirect, 5)]:
        board = starting_board
        while True:
            new_board = deepcopy(board)
            for i, row in enumerate(board):
                for j, seat in enumerate(row):
                    if seat == '#' and sum(board[x][y] == '#' for x, y in neighborhood(i, j) if valid(x, y)) >= max_adj:
                        new_board[i][j] = 'L'
                    elif seat == 'L' and all(board[x][y] != '#' for x, y in neighborhood(i, j) if valid(x, y)):
                        new_board[i][j] = '#'

            if board == new_board:
                print(sum(c == '#' for row in new_board for c in row))
                break

            board = new_board
