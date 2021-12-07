from sys import stdin

if __name__ == '__main__':
    data = [int(i) for i in stdin.read().split(',')]

    lowest = float('inf')
    for k in range(min(data), max(data) + 1):
        s = sum(abs(d-k) for d in data)
        if s < lowest:
            lowest = s
    print(lowest)

    lowest = float('inf')
    for k in range(min(data), max(data) + 1):
        s = sum((abs(d - k) * (abs(d - k) + 1))//2 for d in data)
        if s < lowest:
            lowest = s
    print(lowest)
