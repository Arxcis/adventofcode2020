import fileinput
from copy import deepcopy

if __name__ == '__main__':
    tiles = [line.replace('w', 'w,').replace('e','e,').split(',')[:-1] for line in fileinput.input()]

    #        NW - W
    #      /  | / |
    #    NE - O - SW
    #     | / |  /
    #     E - SE
    neighborhood = {'w':  (1,  1), 'e':  (-1, -1),
                    'nw': (0,  1), 'se': (0, -1),
                    'ne': (-1, 0), 'sw': (1, 0)}
    board = {(0, 0): False}
    # ================================================ PART ONE ================================================
    for tokens in tiles:
        p = (0, 0)
        for token in tokens:
            x, y = neighborhood[token]
            p = p[0] + x, p[1] + y
        if p not in board:
            board[p] = False

        board[p] = not board[p]
    print(sum(board.values()))

    # ================================================ PART TWO ================================================
    for day in range(100):
        board_ = deepcopy(board)  # keep an unchanged state for lookups of "current" state

        # Expand the search area - because we depend on tiles with neighborhoods containing black tiles
        # we can use the inverse relation of neighborhoods of black tiles to add white tiles to the board
        for t in (t for t in board_.keys() if board_[t]):
            for t_ in ((t[0] + n[0], t[1] + n[1]) for n in neighborhood.values()):
                if t_ not in board:
                    board[t_] = False

        for tile, black in board.items():
            adjacent_black = sum(board_.get((tile[0] + n[0], tile[1] + n[1]), False) for n in neighborhood.values())
            board[tile] = not (adjacent_black == 0 or adjacent_black > 2) if black else adjacent_black == 2
    print(sum(board.values()))
