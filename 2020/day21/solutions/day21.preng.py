from functools import reduce
from sys import stdin
import math
import re

# dev tip:
# watchman-make -p 'io/*.input' 'solutions/*.py' --run "cat io/preng.input | /usr/local/opt/python@3.8/bin/python3.8 solutions/day21.preng.py"

def get_stdin():
    return [line.rstrip() for line in stdin]

def parseallergens(lines):
    maybes = {}
    free = set()
    ingredientset = set()
    foods = []
    for l in lines:
        parts = l.split(" (contains ")
        ingredients = parts[0].split(" ")
        ingredientset.update(ingredients)
        foods.append(ingredients)
        if len(parts) < 1:
            for i in ingredients:
                free.add(i)
        else:
            allergens = parts[1][:-1].split(", ")
            for a in allergens:
                if a not in maybes:
                    maybes[a] = [ingredients]
                else:
                    maybes[a].append(ingredients)
    return free, maybes, ingredientset, foods

def common(foods): # ingredients common to foods containing the same allergen
    if len(foods) < 1:
        return []
    common = set(foods[0])
    for food in foods[1:]:
        common = common.intersection(set(food))
    return common

def cleanallergenmap(certains): # one allergen per ingredient, by elimination
    locked = set()
    cleaned = False
    while not cleaned:
        cleaned = True
        for allergen in certains:
            if len(certains[allergen]) == 1:
                locked.update(certains[allergen])
            else:
                tmp = certains[allergen] - locked
                if len(tmp) < len(certains[allergen]):
                    certains[allergen] = tmp
                    cleaned = False
    return certains

# PART 1

lines = get_stdin()
free, maybes, ingredientset, allfoods = parseallergens(lines)
#print(free, maybes)
certains = {}
for allergen, foods in maybes.items():
    overlap = common(foods)
    certains[allergen] = overlap
    #print(allergen, overlap)
    ingredientset -= overlap

#print(ingredientset)
count = 0
for food in allfoods:
    freeset = set(food).intersection(ingredientset)
    #print(freeset)
    count += len(freeset)
print(count)

# PART 2

certains = cleanallergenmap(certains)
#print(certains)

keys = sorted([key for key in certains])
print(",".join([",".join(sorted(certains[key])) for key in keys]))
