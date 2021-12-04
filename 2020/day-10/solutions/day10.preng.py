from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

numbers = [int(l) for l in get_stdin()]
numbers.sort()

# PART 1

counts = [0, 1, 0, 1]

prev = numbers[0]
for number in numbers[1:]:
    d = number - prev
    if d > 3 or d < 1:
        print("cannot connect",prev,"and",number)
        break
    counts[d] += 1
    prev = number

print(counts[1] * counts[3])

# PART 2

numbers = [0] + numbers
answers = [0 for n in numbers]

def ways(somenumbers, offset):
    if len(somenumbers) < 3:
        return 1
    numways = 0
    idxd = 1
    while idxd < len(somenumbers) and somenumbers[idxd] < somenumbers[0] + 4:
        if answers[offset + idxd] == 0:
            newanswer = ways(somenumbers[idxd:], offset + idxd)
            numways += newanswer
            answers[offset + idxd] = newanswer 
        else:
            numways += answers[offset + idxd]
        idxd += 1
    return numways

print(ways(numbers, 0))
