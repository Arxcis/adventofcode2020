import fileinput

if __name__ == '__main__':
    lines = [
        (p[0].split(), []) if len(p) == 1 else (p[0].split(), p[1][:-2].replace(' ', '').split(','))
        for p in (line.split(" (contains ") for line in fileinput.input())
    ]
    # ========== TASK 1 ==========
    allergen_candidates = dict()
    all_ingredients = []
    for food, allergens in lines:
        all_ingredients.extend(food)
        for a in allergens:
            if a in allergen_candidates:
                allergen_candidates[a].intersection_update(food)
            else:
                allergen_candidates[a] = {*food}
    all_ingredients_with_allergens = {a for allergens in allergen_candidates.values() for a in allergens}

    print(sum(ingredient not in all_ingredients_with_allergens for ingredient in all_ingredients))

    # ========== TASK 2 ==========
    ingredients_with_allergen = dict()
    while len(ingredients_with_allergen) < len(allergen_candidates):
        for allergen, ingredients in allergen_candidates.items():
            unnaccounted_allergens = all_ingredients_with_allergens.difference(ingredients_with_allergen.values())
            valid_mappings = ingredients.intersection(unnaccounted_allergens)
            if len(valid_mappings) == 1:
                ingredients_with_allergen[allergen] = valid_mappings.pop()

    print(','.join(v for _, v in sorted(ingredients_with_allergen.items())))
