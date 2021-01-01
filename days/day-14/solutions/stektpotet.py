from sys import stdin
import itertools

if __name__ == '__main__':
    program = stdin.readlines()

    # === Part 1 ===
    instructions = []
    for line in program:
        if line[1] == 'a':  # Is this line defining a mask?
            instructions.append((line.split()[-1], []))
        else:
            instructions[-1][1].append((int(line.split(']')[0][4:]), f"{int(line.split('=')[-1]):036b}"))

    mem = dict()
    for m, ops in instructions:
        for pos, v in ops:
            vs = []
            for i, x in enumerate(v):
                c = m[i - len(v)]
                vs.append(x if c == 'X' else c)
            val = ''.join(vs)
            mem[pos] = int(val, 2)
    print(sum(mem.values()))

    # === Part 2 ===

    instructions.clear()
    mem.clear()

    for line in program:
        if line[1] == 'a':  # Is this line defining a mask?
            instructions.append((line.split()[-1], []))
        else:
            instructions[-1][1].append((f"{int(line.split(']')[0][4:]):036b}", f"{int(line.split('=')[-1]):036b}"))

    for m, ops in instructions:
        for pos, v in ops:
            xs = []
            addr = [c for c in m]
            for i, p in enumerate(pos):
                if m[i] == '0':
                    addr[i] = p
                elif m[i] == 'X':
                    xs.append(i)
            addrs = []
            for p in itertools.product('01', repeat=len(xs)):
                for i, xi in enumerate(xs):
                    addr[xi] = p[i]
                addrs.append(int(''.join(addr), 2))

            for a in addrs:
                mem[a] = int(v, 2)

    print(sum(mem.values()))

