import fileinput

def line_processor(l: str):
    k, vals = l.split(" bags contain ")
    vals = vals.split()
    vals = [(vals[i], ' '.join(vals[i+1:i + 3])) for i in range(0, len(vals), 4)]
    return k, vals

rules = dict(line_processor(line) for line in fileinput.input())

candidates = set()
last_len = len(candidates)
while True:
    for k, c in rules.items():
        for n, e in c:
            if e == 'shiny gold' or e in candidates:
                candidates.add(k)
    if len(candidates) == last_len:
        break
    last_len = len(candidates)

print(len(candidates))

def recurse(bag_rule) -> int:
    count = 0
    for num, contained_bag in bag_rule:
        if num == 'no':
            continue
        count += int(num) + int(num) * recurse(rules[contained_bag])
    return count

print(recurse(rules['shiny gold']))
