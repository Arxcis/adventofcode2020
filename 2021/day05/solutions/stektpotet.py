# from sys import stdin
from typing import Dict, Tuple


def display(board: Dict[Tuple[int, int], int], xmax: int, ymax: int):
    s = ''
    for y in range(ymax+1):
        for x in range(xmax+1):
            v = board.get((x, y))
            s += '.' if v is None else str(v)
        s += '\n'
    print(s)

if __name__ == '__main__':
    data = [tuple(map(int, e.split(','))) for e in open(0).read().replace(' -> ', '\n').splitlines()]
    xs, ys = zip(*data)
    xmax, ymax = max(xs), max(ys)
    # board = [0] * max(data, key=lambda t: t[0])[0]
    # print(len(board), max(data, key=lambda t: t[1])[1])
    segments = [data[i:i+2] for i in range(0, len(data), 2)]
    straight_segments = list(filter(lambda s: s[0][0] == s[1][0] or s[0][1] == s[1][1], segments))
    board = dict()

    s = 0
    for p, q in straight_segments:
        xinc = 1 if p[0] <= q[0] else -1
        yinc = 1 if p[1] <= q[1] else -1
        for y in range(p[1], q[1] + yinc, yinc):
            for x in range(p[0], q[0] + xinc, xinc):
                if (v := board.get((x, y), 0)) == 1:
                    s += 1
                board[(x, y)] = v + 1
    print(s)
    diagonal_segments = list(filter(lambda s: abs(s[0][0] - s[1][0]) - abs(s[0][1] - s[1][1]) == 0, segments))
    for p, q in diagonal_segments:
        xinc = 1 if p[0] <= q[0] else -1
        yinc = 1 if p[1] <= q[1] else -1
        for x, y in zip(range(p[0], q[0] + xinc, xinc), range(p[1], q[1] + yinc, yinc)):
            if (v := board.get((x, y), 0)) == 1:
                s += 1
            board[(x, y)] = v + 1
    print(s)
