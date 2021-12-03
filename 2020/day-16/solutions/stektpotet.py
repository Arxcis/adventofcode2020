import itertools
from random import shuffle
from sys import stdin
from collections import OrderedDict
from typing import List

if __name__ == '__main__':
    rules_in, ticket_in, nearby_in = stdin.read().split('\n\n')

    nearby_tickets = [(*map(int, l.split(',')),) for l in nearby_in.split('\n')[1:-1]]
    my_ticket = list(map(int, ticket_in.split('\n')[1].split(',')))

    rule_fields = dict()
    for line in rules_in.split('\n'):
        label, values = line.split(':')
        rule_fields[label] = []
        values = values.strip().split('or')
        for v in values:
            a, b = map(int, v.split('-'))
            for n in range(a, b + 1):
                rule_fields[label].append(n)

    invalid_fields = []
    valid_tickets = []
    for t in nearby_tickets:    # loop over nearby_tickets
        invalid_ticket = False
        for f in t:             # loop over fields of said ticket
            if not any(f in num_range for num_range in rule_fields.values()):
                invalid_fields.append(f)
                invalid_ticket = True
        if not invalid_ticket:
            valid_tickets.append(t)
    print(sum(invalid_fields))

    fields = list(zip(*valid_tickets))
    candidates = {k: [] for k in rule_fields.keys()}

    for k, r in rule_fields.items():
        for i, f in enumerate(fields):
            if all(value in r for value in f):
                candidates[k].append(i)

    candidates = OrderedDict(sorted(candidates.items(), key=lambda elem: len(elem[1])))

    def find_unsolved(solution):
        for k, candidates in solution.items():
            if isinstance(candidates, List):
                return k
        return None

    def validate(solution, key, index):
        for k, v in solution.items():
            if v == index:
                return False
        return True

    def solve(open, solved=None):
        if solved is None:
            solved = {}
        # print(solution)
        # print(unused_indices)
        key = find_unsolved(open)
        if key is None:
            return True, solved
        for index in open[key]:
            if validate(solved, key, index):
                candidates = open.pop(key)
                solved[key] = index
                ok, partial_solution = solve(open, solved)
                if ok:
                    return True, partial_solution
                open[key] = candidates
        return False, solved

    success, solution = solve(candidates)
    if not success:
        print('Failed solving constraints!')
    prod = 1
    for val in (my_ticket[v] for k, v in solution.items() if k.find('departure') == 0):
        prod *= val
    print(prod)
