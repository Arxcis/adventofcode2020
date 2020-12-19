from functools import reduce
from sys import stdin
import math
import re

# Long winded code that does not use high-level system libraries

def get_stdin():
    return [line.rstrip() for line in stdin]

def tokenize(expr):
    #  2 3 | 3 2
    # "a"
    matchlists = []
    pos = 0
    thislist = []
    while pos < len(expr):
        c = expr[pos]
        if c == " ":
            pos += 1
        elif c == "\"":
            return [expr[pos+1]]
        elif c == "|":
            matchlists.append(thislist)
            thislist = []
            pos += 1
        else:
            ruleidstr = re.findall(r'-{0,1}\d+', expr[pos:])[0]
            thislist.append(int(ruleidstr))
            pos += len(ruleidstr)
    if len(thislist) > 0:
        matchlists.append(thislist)
    return matchlists

class Rule:
    def __init__(self, rid, matches):
        self.id = rid
        self.char = None
        self.matches = None
        if isinstance(matches[0], str):
            self.char = matches[0]
        else:
            self.matches = matches

    def __str__(self):
        if self.char is not None:
            return self.char
        else:
            return "%s" % (self.matches)

    def __repr__(self):
        return self.__str__()

    def match1(self, ruleset, pattern):  # return match and number of characters consumed to match
        if len(pattern) == 0:
            return 0, 0
        if self.char is not None:
            if self.char == pattern[0]:
                return 1, 1
            else:
                return 0, 0
        for rules in self.matches:
            pos = 0
            for rid in rules:
                r = ruleset[rid]
                ismatch, consumed = r.match1(ruleset, pattern[pos:])
                if not ismatch:
                    pos = 0
                    break
                else:
                    pos += consumed
            if pos > 0:
                return 1, pos
        return 0, 0

    def match2(self, ruleset, pattern):
        if self.id != 0:
            return self.match1(ruleset, pattern)
        #
        #  0: [[8, 11]]
        #  8: 42 | 42 8
        # 11: 42 31 | 42 11 31
        #
        # Hack: accept 42{1,n} 31{1,m}  n > m
        r42 = ruleset[42]
        r31 = ruleset[31]
        pos = 0
        cnt42 = 0
        cnt31 = 0
        while pos < len(pattern):
            ismatch, consumed = r42.match1(ruleset, pattern[pos:])
            if not ismatch and cnt42 > 0:
                break
            if not ismatch and cnt42 == 0:
                return 0, 0
            if pos + consumed == len(pattern):
                return 0, 0
            pos += consumed
            cnt42 += 1
        while pos < len(pattern):
            ismatch, consumed = r31.match1(ruleset, pattern[pos:])
            if not ismatch and cnt31 > 0:
                break
            if not ismatch and cnt31 == 0:
                return 0, 0
            pos += consumed
            cnt31 += 1
        if pos == len(pattern) and cnt42 > cnt31 and cnt31 > 0:
            return 1, pos
        return 0, 0

def getrules(lines):
    #  1: 2 3 | 3 2
    rules = {}
    l = lines.pop(0)
    while re.match("\d+: ", l):
        parts = l.split(": ")
        ruleid = int(parts[0])
        rules[ruleid] = Rule(ruleid, tokenize(parts[1]))
        l = lines.pop(0)
    return rules, lines

def match1(ruleset, lines):
    matchcnt = 0
    for l in lines:
        cnt = len(l)
        if cnt == 0 or len(re.findall("\w", l)) == 0:
            continue
        ok, consumed = ruleset[0].match1(ruleset, l)
        if ok > 0 and consumed == cnt:
            matchcnt += 1
    return matchcnt

def match2(ruleset, lines):
    matchcnt = 0
    for l in lines:
        cnt = len(l)
        if cnt == 0 or len(re.findall("\w", l)) == 0:
            continue
        ok, consumed = ruleset[0].match2(ruleset, l)
        if ok > 0 and consumed == cnt:
            matchcnt += 1
    return matchcnt

#print("PART 1")
lines = get_stdin()
ruleset, lines = getrules(lines)
print(match1(ruleset, lines))

#print("PART 2")
    #8: 42 | 42 8
    #11: 42 31 | 42 11 31
    #
    # but.... 0: [[8, 11]]
ruleset[8]  = Rule(8,  tokenize("42 | 42 8"))
ruleset[11] = Rule(11, tokenize("42 31 | 42 11 31"))
print(match2(ruleset, lines))
