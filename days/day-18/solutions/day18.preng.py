from functools import reduce
from sys import stdin
import math
import re

# Long winded code that does not use high-level system libraries

def get_stdin():
    return [line.rstrip() for line in stdin]

def parentokens(tokens):
    closecnt = 0
    for i in range(len(tokens)):
        t = tokens[i]
        if t == "(":
            closecnt -= 1
        elif t == ")":
            closecnt += 1
            if closecnt == 1:
                return tokens[0:i], tokens[i+1:]
    print("unbalanced", tokens)

def tokenize(expr):
    tokens = []
    pos = 0
    while pos < len(expr):
        c = expr[pos]
        if c == " ":
            pos += 1
        elif c == "(":
            tokens.append(c)
            pos += 1
        elif c == ")":
            tokens.append(c)
            pos += 1
        elif c == "+":
            tokens.append(sum)
            pos += 1
        elif c == "*":
            tokens.append(math.prod)
            pos += 1
        else:
            token = re.findall(r'-{0,1}\d+', expr[pos:])[0]
            tokens.append(int(token))
            pos += len(token)
    return tokens      

def presedence(a, b):
    return a == sum and b == math.prod

def parsenext(tokens, builder):
    if len(tokens) == 1:
        return tokens[0], []
    t = tokens.pop(0)
    if t == "(":
        inside, tail = parentokens(tokens)
        return parsetree(inside, builder), tail
    else:
        return parsetree([t], builder), tokens

def parsetree(tokens, builder, left = None):
    op = None
    right = None
    if len(tokens) == 1:
        return Expr(None, tokens[0], None)
    if left is None:
        left, tokens = parsenext(tokens, builder)
    if len(tokens) == 0:
        return Expr(None, left, None)
    op = tokens.pop(0)
    right, tokens = parsenext(tokens, builder)
    if len(tokens) == 0:
        return Expr(op, left, right)
    return builder(op, left, right, tokens)

def part1builder(op, left, right, tail):
    return parsetree(tail, part1builder, Expr(op, Expr(None,left,None), Expr(None,right,None)))

def part2builder(op, left, right, tail):
    if presedence(tail[0], op):
        op2 = tail[0]
        nexttoken, tail = parsenext(tail[1:], part2builder)
        return Expr(op, left, parsetree(tail, part2builder, Expr(op2, right, nexttoken)))
    else:
        return parsetree(tail, part2builder, Expr(op, Expr(None,left,None), Expr(None,right,None)))

class Expr:
    def __init__(self, op, left, right):
        self.op = op
        self.left = left
        self.right = right

    def isplus(self):
        return self.op is not None and self.op == sum

    def ismult(self):
        return self.op is not None and self.op == math.prod

    def calc(self):
        if self.isplus():
            return self.value(self.left) + self.value(self.right)
        elif self.ismult():
            return self.value(self.left) * self.value(self.right)
        else:
            return self.value(self.left)

    def value(self, node):
        if isinstance(node, Expr):
            return node.calc()
        else:
            return node
    
    def __str__(self):
        if self.op is None:
            return "%s" % (self.left)
        if self.isplus():
            return "(%s + %s) " % (self.left, self.right)
        else:
            return "(%s * %s) " % (self.left, self.right)

    def __repr__(self):
        return self.__str__()


# PART 1
lines = get_stdin()
print(sum([parsetree(tokenize(l), part1builder).calc() for l in lines]))

# PART 2
print(sum([parsetree(tokenize(l), part2builder).calc() for l in lines]))
