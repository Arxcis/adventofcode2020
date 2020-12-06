from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

def bin(item, l, r, lowerFlag):
    for char in item:
        m = (r + l) // 2
        if char == lowerFlag:
            r = m
        else:
            l = m + 1
    return r


ids = [
        (bin(item[:7], 0, 127, "F") * 8) + bin(item[7:], 0, 7, "L")
        for item in get_stdin()
]
print(max(ids))
for id in range(min(ids), max(ids)):
    if id not in ids and (id-1) in ids and (id+1) in ids:
        print(id)
