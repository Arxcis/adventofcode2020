import sys
input_grouped = sys.stdin.read().split('\n\n')
print(sum([len(set(c for c in l if c != '\n')) for l in input_grouped]))
print(sum([len(set.intersection(*[set(c for c in g) for g in l.split()])) for l in input_grouped]))

