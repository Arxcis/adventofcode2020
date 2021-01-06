import fileinput

sorted_bag = sorted(int(n) for n in fileinput.input())
sorted_bag.append(sorted_bag[-1] + 3)  # add the last step
# ========== TASK 1 ==========
d = {1: 0, 3: 0}
j = 0
for n in sorted_bag:
    d[n - j] += 1
    j = n
print(d[1] * d[3])

# ========== TASK 2 ==========
bag = set(sorted_bag)
found_already = dict()

def recurse(jolt=0):
    num_permutations = 0
    found_result = found_already.get(jolt, False)
    if found_result:
        return found_result
    if jolt == sorted_bag[-1]:
        return 1
    for jolt_step in range(1, 4):  # The possible next steps
        if jolt_step + jolt in bag:
            num_permutations += recurse(jolt_step + jolt)
    found_already[jolt] = num_permutations
    return num_permutations

print(recurse())
