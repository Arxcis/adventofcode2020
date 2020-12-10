from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()

def parseRight(l):
    sub = l.rstrip(".")
    s = sub.index(" ")
    if sub[:s] == "no":
        return
    count = int(sub[:s])
    subname = sub[s+1:].rstrip("s")
    return dict([('name', subname), ('count', count)])

def parseRule(l):
    # vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    # faded blue bags contain no other bags.
    sides = l.split(" contain ")
    if len(sides) < 2:
        print("surprise line", l)
        return None
    subs = [parseRight(l) for l in sides[1].split(", ")]
    rule = dict([('name', sides[0].rstrip("s")), ('subs', subs)])
    return rule

rulelist = [parseRule(l) for l in lines]

canBeIn = dict()
for r in rulelist:
    parent = r['name']
    for s in r['subs']:
        if s is not None:
            #print(canBeIn)
            if canBeIn is None or s['name'] not in canBeIn:
                canBeIn[s['name']] = {parent}
            else:
                canBeIn[s['name']].add(parent)

#print(canBeIn)

def findParents(childname):
    r = set()
    if childname in canBeIn:
        for parentname in canBeIn[childname]:
            #print(childname, r, parentname)
            r.add(parentname)
            #print(childname, r)
            parents = findParents(parentname)
            if parents is not None:
                r = r.union(parents)
    return r

#print(len(canBeIn['shiny gold bag']))
print(len(findParents('shiny gold bag')))

## Part 2
#print("PART 2")
contains = dict()

for r in rulelist:
    contains[r['name']] = r['subs']

def countBags(subs):
    count = 0
    for sub in subs:
        #print("sub", sub)
        if sub is not None:
            #print("sub not none")
            count += sub['count']
            if sub['name'] in contains:
                count += sub['count'] * countBags(contains[sub['name']])
            #print(count)
    return count

#print(contains)
print(countBags(contains['shiny gold bag']))
