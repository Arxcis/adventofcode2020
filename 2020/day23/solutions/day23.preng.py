from functools import reduce
from sys import stdin
import math
import re

# dev tip:
# watchman-make -p 'io/*.input' 'solutions/*.py' --run "cat io/preng.input | /usr/local/opt/python@3.8/bin/python3.8 solutions/day23.preng.py"

def get_stdin():
    return [line.rstrip() for line in stdin]

def getnumbers(lines):
    return [int(c) for c in lines[0]]


class Cup:
    def __init__(self, number, next = None):
        self.number = number
        self.next = next

    def find(self, value): # open or circular lists
        if value == self.number:
            return self
        n = self.next
        while n is not None and n != self:
            if n.number == value:
                return n
            n = n.next
        return None

class Cups:
    def __init__(self, numbers):
        self.nodemap = {}
        nodes = [Cup(num) for num in numbers]
        for i in range(len(nodes)):
            nodes[i].next = nodes[(i+1) % len(nodes)]
            self.nodemap[nodes[i].number] = nodes[i]
        self.current = nodes[0]
        self.maxval = max(numbers)

    def take3(self):
        three = self.current.next
        self.current.next = self.current.next.next.next.next
        three.next.next.next = None
        return three

    def place(self, three):
        targetval = self.current.number - 1
        if targetval < 1:
            targetval = self.maxval
        crash = three.find(targetval)
        while crash is not None:
            targetval -= 1
            if targetval < 1:
                targetval = self.maxval
            crash = three.find(targetval)
        before = self.nodemap[targetval]
        three.next.next.next = before.next
        before.next = three

    def resultstring(self):
        oneat = self.nodemap[1]
        n = oneat.next
        res = ""
        while n != oneat:
            res += "%d" % (n.number)
            n = n.next
        return res
    
    def part2result(self):
        oneat = self.nodemap[1]
        r1 = oneat.next.number
        r2 = oneat.next.next.number
        return r1, r2, r1*r2

    def printmove(self, move):
        cur = self.current
        res = "Move %d: (%d)" % (move, cur.number)
        n = cur.next
        cnt = 0
        while n != cur and cnt < 10:
            res += "  %d" % (n.number)
            n = n.next
            cnt += 1
        print(res)
        print(self.part2result())
        print()

    def move(self, ):
        three = self.take3()
        self.place(three)
        self.current = self.current.next

    def play(self, moves, debug = False):
        for i in range(moves):
            if debug:
                self.printmove(i+1)
            self.move()


originals = getnumbers(get_stdin())

# PART 1
numbers = originals[:]
cups = Cups(numbers)
cups.play(100, False)
print(cups.resultstring())

# PART 2
numbers = originals + [n for n in range(10, 1000001)]
cups = Cups(numbers)
cups.play(10000000, False)
a, b, product = cups.part2result()
print(product)

