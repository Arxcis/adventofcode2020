import copy
import sys
from typing import List


def parse(line):
    def recurse(it):
        expressions = []
        for c in it:
            if c == ')':  # because we receive the reversed expression, parentheses are the wrong way around
                expr = recurse(it)
                expressions.append(expr)
            elif c == '(':
                return expressions
            else:
                if c.isnumeric():
                    expressions.append(int(c))
                else:
                    expressions.append(c)
        return expressions
    return recurse(line)

def add_operator_precedence(expr):
    if not isinstance(expr, List):
        return expr
    i = 0
    while i < len(expr):
        if expr[i] == '+':
            expr[i-1] = [expr[i-1], expr.pop(i), add_operator_precedence(expr.pop(i))]
        else:
            add_operator_precedence(expr[i])
            i += 1
    return expr

def compute(expr):
    if not isinstance(expr, List):
        return expr
    op_map = {'+': (lambda a, b: a + b), '*': (lambda a, b: a * b)}
    a = compute(expr.pop())
    while len(expr) > 1:
        op = expr.pop()
        b = expr.pop()
        a = op_map[op](a, compute(b))
    return a

if __name__ == '__main__':
    lines = [parse(reversed(l.replace(' ', ''))) for l in sys.stdin.read().split('\n')[:-1]]
    print(sum([compute(l) for l in copy.deepcopy(lines)]))
    print(sum([compute(add_operator_precedence(l)) for l in copy.deepcopy(lines)]))
