from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

def parse(line):
    # acc -99
    parts = line.split(" ")
    op = parts[0]
    arg = int(parts[1][1:])
    if parts[1][0] == "-":
        arg *= -1
    return op, arg

def fix(lines, idx):
    newlines = lines.copy()
    op, arg = parse(newlines[idx])
    if op == "nop":
        newlines[idx] = "jmp" + lines[idx][3:]
    elif op == "jmp":
        newlines[idx] = "nop" + lines[idx][3:]
    return newlines

lines = get_stdin()

# PART 1

acc = 0
pc = 0
visited = dict()
done = False

while not done:
    if pc in visited:
        print(acc)
        done = True
    else:
        visited[pc] = True
        op, arg = parse(lines[pc])
        #print("exec", pc, op, arg)
        if op == "acc":
            acc += arg
            pc += 1
        elif op == "jmp":
            pc += arg
        else:
            pc += 1

# PART 2

success = False
last = len(lines)

for idx in range(last):
    acc = 0
    pc = 0
    visited = dict()
    done = False
    newlines = fix(lines, idx)
    while not done:
        if pc >= last:
            print(acc)
            done = True
            success = True
        elif pc in visited:
            #print("infinite fixing", idx)
            done = True
        else:
            visited[pc] = True
            op, arg = parse(newlines[pc])
            #print("exec", pc, op, arg)
            if op == "acc":
                acc += arg
                pc += 1
            elif op == "jmp":
                pc += arg
            else:
                pc += 1
    if success:
        break
