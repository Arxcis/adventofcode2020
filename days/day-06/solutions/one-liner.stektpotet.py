import sys; [print(sum(n)) for n in zip(*[(len(set(c for c in l if c != '\n')), len(set.intersection(*[set(c for c in g) for g in l.split()]))) for l in sys.stdin.read().split('\n\n')])]
