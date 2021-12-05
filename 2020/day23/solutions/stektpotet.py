from sys import stdin
from typing import Dict, Any, List, Optional, TypeVar, Iterator, Generic

T = TypeVar('T')


class Sequencer(Generic[T]):
    def __init__(self, data: List[T], sequence: Optional[Dict[int, int]] = None):
        self.min, self.max = min(data), max(data)
        if sequence is None:
            sequence = {i % len(data): (i+1) % len(data) for i in range(-1, len(data))}  # circular sequence
        self._sequence_mapping = sequence
        self._lookup = {v: i for i, v in enumerate(data)}
        self._data = data

    def __len__(self) -> int:
        return len(self._data)

    def __getitem__(self, i: int) -> T:
        return self._data[i]

    def find(self, value: T) -> int:
        return self._lookup[value]

    def next(self, i: int) -> int:
        return self._sequence_mapping[i]

    def get_subsequence(self, i: int, n: int) -> Iterator[T]:
        for _ in range(n):
            yield i
            i = self._sequence_mapping[i]

    def get_subsequence_values(self, i: int, n: int) -> Iterator[T]:
        for _ in range(n):
            yield self._data[i]
            i = self._sequence_mapping[i]

    def re_sequence(self, start: int, end: int, destination: int):
        """
        Re organize sequence from:
        [start, a, b, c, d, end, f, g, h, i, j, destination, l, m]
        to:
        [start, f, g, h, i, j, destination, a, b, c, d, end, l, m]
        """
        a = self.next(start)                                    # the starting point of the sub-sequence to move
        self._sequence_mapping[start] = self.next(end)          # make 'start' point to what's after 'end'
        self._sequence_mapping[end] = self.next(destination)    # make 'end' point to what's after 'destination'
        self._sequence_mapping[destination] = a                 # make 'destination' point to what was after 'start'


def play_cups(puzzle: List[Any], num_steps: int, num_out: Optional[int] = None):
    if num_out is None:
        num_out = len(puzzle) - 1
    sequencer = Sequencer(puzzle)
    current_index = 0
    for step in range(num_steps):
        picked_up_indices = tuple(sequencer.get_subsequence(sequencer.next(current_index), 3))
        picked_up_values = tuple(sequencer[i] for i in picked_up_indices)

        destination_value = sequencer[current_index] - 1 if sequencer[current_index] > sequencer.min else sequencer.max
        while destination_value in picked_up_values:
            if destination_value > sequencer.min:
                destination_value = destination_value - 1
            else:
                destination_value = sequencer.max

        destination_index = sequencer.find(destination_value)
        sequencer.re_sequence(current_index, picked_up_indices[-1], destination_index)
        current_index = sequencer.next(current_index)
    return sequencer.get_subsequence_values(sequencer.next(sequencer.find(1)), num_out)


if __name__ == '__main__':
    puzzle_input = [int(c) for c in stdin.readline()[:-1]]
    print(''.join(map(str, play_cups(puzzle_input, 100))))
    puzzle_input.extend(range(max(puzzle_input)+1, 1000000+1))
    a, b = play_cups(puzzle_input, 10000000, 2)
    print(a * b)
