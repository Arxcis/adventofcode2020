from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()
lines.append("")

answers = {}
part1count = 0

for l in lines:
    if len(l) < 1:
        part1count += len(answers)
        answers = {}
    else:
        for char in l:
            answers[char] = 1

print(part1count)

answers = {}
part2count = 0
groupsize = 0

for l in lines:
    if len(l) < 1:
        for k in answers.keys():
            if answers[k] == groupsize:
                part2count += 1
        groupsize = 0
        answers = {}
    else:
        groupsize += 1
        for char in l:
            if char in answers.keys():
                answers[char] += 1
            else:
                answers[char] = 1

print(part2count)

