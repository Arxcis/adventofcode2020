from sys import stdin
from typing import List


class Board:
    def __init__(self, data: List[List[int]]):
        self.data = data
        self.remaining = set(item for row in data for item in row)
        self.line_sums = [0] * (len(data[0]) + len(data))

    def pop(self, item):
        if item in self.remaining:
            for i, row in enumerate(self.data):
                if item in row:
                    self.line_sums[i] += 1
                    self.line_sums[len(self.data) + row.index(item)] += 1
            self.remaining.remove(item)
            for s in self.line_sums:
                if s >= len(self.data):
                    return True
        return False

    def __str__(self):
        return '\n'.join(f"[{', '.join(str(col) for col in row)}]" for row in self.data)

if __name__ == '__main__':
    draws_raw, *boards_raw = stdin.read().split('\n\n')
    draws = [int(nr) for nr in draws_raw.split(',')]
    boards = set(Board([[int(c) for c in row.strip().split()] for row in board.splitlines()]) for board in boards_raw)

    pq = []
    for elem in draws:
        for board in list(boards):
            if board.pop(elem):
                pq.append(sum(board.remaining) * elem)
                boards.remove(board)
    print(pq[0], pq[-1], sep='\n')
