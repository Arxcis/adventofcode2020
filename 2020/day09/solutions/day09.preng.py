from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

numbers = [int(l) for l in get_stdin()]

# PART 1

def valid(numbers, pre, idx):
    left = idx - pre
    for i in range(left, idx - 1):
        for j in range(i+1, idx):
            if numbers[i] != numbers[j] and numbers[i] + numbers[j] == numbers[idx]:
                return True
    return False

pre = 25

target = 0
targetAt = 0

for idx in range(pre, len(numbers)):
    if not valid(numbers, pre, idx):
        target = numbers[idx]
        targetAt = idx
        print(target)
        break

# PART 2

for i in range(0, targetAt - 1):
    sum = numbers[i]
    for j in range(i+1, targetAt):
        sum += numbers[j]
        if sum == target:
            print(min(numbers[i:j+1]) + max(numbers[i:j+1]))
            exit(0)
        elif sum > target:
            break
