from sys import stdin
from functools import reduce
from operator import mul

if __name__ == '__main__':
    inputs = stdin.read().split('\n')[:-1]
    time = int(inputs[0])
    ids = {i: int(id) for i, id in enumerate(inputs[1].split(',')) if id.isnumeric()}

    overflow_asc = sorted(ids.items(), key=lambda k: (1 + time//k[1])*k[1])
    least_overflowing = overflow_asc[0][1]

    # solution part 1:
    print(((1 + time//least_overflowing) * least_overflowing - time) * least_overflowing)

    sorted_ids = sorted({-i % id: id for i, id in ids.items()}.items(), key=lambda k: -k[1])
    delays, buses = zip(*sorted_ids)

    d, r = sorted_ids[0]
    for delay, bus_id in sorted_ids[1:]:
        while d % bus_id != delay:
            d += r
        r *= bus_id
    print(d)
