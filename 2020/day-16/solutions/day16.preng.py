from functools import reduce
from sys import stdin
import math

# Horror below. You have been warned.


def get_stdin():
    return [line.rstrip() for line in stdin]

lines = get_stdin()

# PART 1

def parseInterval(itext):
    return [int(n) for n in itext.split("-")]

def parseRule(l):
    parts = l.split(": ")
    name = parts[0]
    intervals = [parseInterval(itext) for itext in parts[1].split(" or ")]
    return [name, intervals]

def valid(rule, num):
    for interval in rule[1]:
        if num >= interval[0] and num <= interval[1]:
            return True
    return False

def validTicket(rules, ticket):
    for n in ticket:
        for r in rules:
            if valid(r, n):
                return True
    return False
 

rules = []
tickets = [] # first ticket is mine
blanksSeen = 0

for l in lines:
    if l == "":
        blanksSeen += 1
    elif blanksSeen == 0:
        rules.append(parseRule(l))
    elif l.find("ticket") < 0:
        tickets.append([int(n) for n in l.split(",")])

#print(rules)
#print(tickets)

validTickets = tickets[0:1]
invalids = []
for ticket in tickets[1:]:
    allok = True
    for n in ticket:
        ok = False
        for r in rules:
            ok = ok | valid(r, n)
            if ok:
                break
        if not ok:
            invalids.append(n)
            allok = False
    if allok:
        validTickets.append(ticket)

#print(invalids)
print(sum(invalids))
#print(validTickets)

# PART 2

def validIntervals(intervals, num):
    for interval in intervals:
        if num >= interval[0] and num <= interval[1]:
            return True
    return False

def findRules(rules, n):
    matches = set()
    for name, intervals in rules.items():
        if validIntervals(intervals, n):
            matches.add(name)
    return matches

def nonEmptyOverlaps(overlaps):
    for s in overlaps:
        if len(s) > 0:
            return True
    return False

rmap = {}
for r in rules:
    rmap[r[0]] = r[1]

ticketLength = len(tickets[0])
all = set()
for r in rules:
    all.add(r[0])

# set of possible rules for each position on ticket
overlaps = [all.copy() for n in range(ticketLength)]
#print(overlaps)

for ticket in validTickets:
    for i in range(ticketLength):
        matches = findRules(rmap, ticket[i])
        impossible = all - matches
        overlaps[i] = overlaps[i] - impossible

#print("possible:", overlaps)


def findFirstSingle(overlaps):
    for i in range(ticketLength):
        s = overlaps[i]
        if len(s) == 1:
            return i, next(iter(s)) # the single element
    return i, None

def removeOverlap(overlaps, rname):
    mask = set([rname])
    for i in range(ticketLength):
        overlaps[i] -= mask

ruleIdx = {}

while nonEmptyOverlaps(overlaps):
    i, rname = findFirstSingle(overlaps)
    if rname is None:
        print("whoops bad algo")
        break
    ruleIdx[rname] = i
    removeOverlap(overlaps, rname)

#print("after:", overlaps)
#print(ruleIdx)

deprules = []
for r in rules:
    if r[0].find("departure") == 0:
        deprules.append(r[0])

#print(deprules)

my = tickets[0]

def myval(rname):
    idx = ruleIdx[rname]
    return my[idx]

product = 1
for rname in deprules:
    #print(rname, myval(rname))
    product *= myval(rname)

print(product)
