from sys import stdin

def valid_height(x):
    t = x[-2:]
    val = x[:-2]
    if val == "":
        return False
    val = int(val)
    if t == "cm":
        return val >= 150 and val <= 193
    if t == "in":
        return val >= 59 and val <= 76

required_fields  = [
    ("byr", lambda x: int(x) >= 1920 and int(x) <= 2002),
    ("iyr", lambda x: int(x) >= 2010 and int(x) <= 2020),
    ("eyr", lambda x: int(x) >= 2020 and int(x) <= 2030),
    ("hgt", valid_height),
    ("hcl", lambda x: x[:1] == "#" and len(x[1:]) == 6),
    ("ecl", lambda x: x in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]),
    ("pid", lambda x: len(x) == 9)
]


def get_stdin():
    return [line.rstrip() for line in stdin]

def create_passport(inp):
    passports = []
    currentPassport = ""
    for row in inp:
        if row == "":
            passports.append(currentPassport.strip(" "))
            currentPassport = ""
        else:
            currentPassport += " " + row
    passports.append(currentPassport.strip(" "))
    return passports



def valid_passport(parts):
    keys = [part[0:3] for part in parts]
    for field, _ in required_fields:
        if not field in keys:
            return False
    return True

def validate_passport(parts):
    fields = [(part[0:3], part[4:]) for part in parts]
    if not valid_passport(parts):
        return 0
    for field, validator in required_fields:
        f = [i for i in fields if i[0] == field]
        if not validator(f[0][1]):
            return 0
    return 1


data = create_passport([inp for inp in get_stdin()])

# Solve 1
print(sum([1 if valid_passport(item.split(" ")) else 0 for item in data]))

# Solve 2
print(sum([1 if validate_passport(item.split(" ")) else 0 for item in data]))
