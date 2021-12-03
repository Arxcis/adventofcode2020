import sys; [(print(max(ids)), print(i)) for ids in [{int(''.join('0' if c == 'F' or c == 'L' else '1' for c in k), 2) for k in sys.stdin.read().split('\n')[:-1]}] for i in range(min(ids), max(ids)) if not i in ids]

