if __name__ == '__main__':
    timers = [l.count(i) for l in [tuple(map(int, open(0).read().split(',')))] for i in range(9)]
    for day in range(1, 81):
        timers = [*timers[1:7], timers[7] + timers[0], timers[8], timers[0]]
    print(sum(timers))
    for day in range(81, 257):
        timers = [*timers[1:7], timers[7] + timers[0], timers[8],  timers[0]]
    print(sum(timers))
