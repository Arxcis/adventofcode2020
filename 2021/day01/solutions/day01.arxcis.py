import fileinput

puzzle_input = [int(i) for i in fileinput.input() if i.strip().isdigit()]

# --- Part 1 ---

right_is_larger = [(left,right)
                   for left, right in zip(puzzle_input[:-1], puzzle_input[1:])
                   if left < right]

print(len(right_is_larger))

# --- Part 2 -----

measurements = [sum((one, two, three))
                for one, two, three in zip(puzzle_input[:-2], puzzle_input[1:-1], puzzle_input[2:])]

right_is_larger = [(left, right)
                  for left, right in zip(measurements[:-1], measurements[1:])
                  if left < right]

print(len(right_is_larger))
