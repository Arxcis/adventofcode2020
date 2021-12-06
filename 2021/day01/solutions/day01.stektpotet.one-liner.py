import sys; print(*(sum(s) for d in [[int(l) for l in sys.stdin.read().split('\n')]] for s in zip(*((d[i] < q, sum(d[i:i+3]) < sum(d[i+1:i+4])) for i, q in enumerate(d[1:])))), sep='\n')
