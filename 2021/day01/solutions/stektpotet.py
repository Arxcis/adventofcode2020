import fileinput

if __name__ == '__main__':
    data = [int(l) for l in fileinput.input() if l.strip().isdigit()]
    print(sum(data[i] < q for i, q in enumerate(data[1:])))
    print(sum(sum(data[i:i+3]) < sum(data[i+1:i+4]) for i, _ in enumerate(data[3:])))
