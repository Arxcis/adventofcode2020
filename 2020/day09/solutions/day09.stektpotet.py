import fileinput
import itertools

if __name__ == '__main__':
    lines = [int(line) for line in fileinput.input()]
    magic_number = None
    for p in range(len(lines) - 26):
        if not any(s == lines[p+25] for s in map(sum, itertools.combinations(lines[p: p+25], 2))):
            magic_number = lines[p + 25]
            print(magic_number)
            break

    for i, a in enumerate(lines):
        s = a
        r_min = a
        r_max = a
        for j, b in zip(range(i+1, len(lines)), lines[i+1:]):
            s += b
            r_min = min(r_min, b)
            r_max = max(r_max, b)
            if s > magic_number:
                break
            elif s == magic_number:
                print(r_min + r_max)
                exit(0)
