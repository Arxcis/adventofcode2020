import fileinput
from copy import copy

if __name__ == '__main__':
    lines = [(op, int(n)) for op, n in (line.split() for line in fileinput.input())]
    visited = [False]*len(lines)
    p = 0
    acc = 0
    trace = [0]
    while p < len(lines):
        op, n = lines[p]
        if op == 'jmp':
            p += n - 1
        elif op == 'acc':
            acc += n
        p += 1
        trace.append(p)
        if visited[p]:
            break
        visited[p] = True
    print(acc)

    nops_and_jumps = [t for t in trace if lines[t][0] == 'nop' or lines[t][0] == 'jmp']
    for instruction in nops_and_jumps:
        lines_changed = copy(lines)
        oc, nc = lines_changed[instruction]
        if oc == 'nop':
            lines_changed[instruction] = 'jmp', nc
        else:
            lines_changed[instruction] = 'nop', nc
        visited = [False] * len(lines)
        p = 0
        acc = 0
        while p < len(lines_changed):
            op, n = lines_changed[p]
            if op == 'jmp':
                p += n - 1
            elif op == 'acc':
                acc += n
            p += 1
            if p >= len(lines_changed) or visited[p]:
                break
            visited[p] = True
        if p == len(lines_changed):
            print(acc)
