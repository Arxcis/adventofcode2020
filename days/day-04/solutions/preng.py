from sys import stdin

def get_stdin():
    return [line.rstrip() for line in stdin]

def splitkeyval(keyval):
    parts = keyval.split(":")
    return parts[0], parts[1]

def isHex(s):
    for char in s:
        if not char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]:
            return False
        return True

def isNumber(s):
    for char in s:
        if not char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]:
            return False
        return True

def validField(key, v):
    try:
        i = int(v)
    except ValueError:
        i = 0
    l = len(v)
    if key == "byr":
        return l == 4 and i >= 1920 and i <= 2002
    elif key == "iyr":
        return l == 4 and i >= 2010 and i <= 2020
    elif key == "eyr":
        return l == 4 and i >= 2020 and i <= 2030
    elif key == "hgt":
        if l < 3:
            return False
        h = int(v[:l-2])
        u = v[l-2:]
        if u == "cm":
            return h >= 150 and h <= 193
        elif u == "in":
            return h >= 59 and h <= 76
    elif key == "hcl":
        return l == 7 and v[0] == "#" and isHex(v[1:])
    elif key == "ecl":
        return v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    elif key == "pid":
        return l == 9 and isNumber(v)
    elif key == "cid":
        return True
    #print("Surprise field", key, value)
    return False

lines = get_stdin()
lines.append("")

# Part 1

currentfields = {}
valid = 0
for l in lines:
    if len(l) > 0:
        for keyval in l.split():
            key = keyval.split(":")[0]
            currentfields[key] = 1
    else:
        if len(currentfields) > 7:
            #print("valid passport", currentfields)
            valid += 1
        elif len(currentfields) > 6 and not "cid" in currentfields:
            #print("valid NPC", currentfields)
            valid += 1
        #else:
            #print("invalid document", currentfields)
        currentfields = {}

print(valid)

# Part 2

valid = 0
currentfields = {}
isReadingInvalid = False

for l in lines:
    if len(l) > 0 and not isReadingInvalid:
        for keyval in l.split():
            key, value = splitkeyval(keyval)
            if validField(key, value):
                currentfields[key] = value
            else:
                #print("invalid document because", key, value)
                isReadingInvalid = True
                currentfields = {}
                break
    else:
        if len(currentfields) > 7:
            #print("valid passport", currentfields)
            valid += 1
        elif len(currentfields) > 6 and not "cid" in currentfields:
            #print("valid NPC", currentfields)
            valid += 1
        #else:
            #print("invalid document", currentfields)
        currentfields = {}
        isReadingInvalid = False

print(valid)

