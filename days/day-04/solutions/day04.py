import re
import sys

INPUT_FILE = "input.txt"

BIRTH_YEAR = 'byr'
ISSUE_YEAR = 'iyr'
EXPIRATION_YEAR = 'eyr'
HEIGHT = 'hgt'
HAIR_COLOR = 'hcl'
EYE_COLOR = 'ecl'
PASSPORT_ID = 'pid'
COUNTRY_ID = 'cid'

REQUIRED_PROPS = {
    BIRTH_YEAR,
    ISSUE_YEAR,
    EXPIRATION_YEAR,
    HEIGHT,
    HAIR_COLOR,
    EYE_COLOR,
    PASSPORT_ID,
}


class Passport:
    def __init__(self, text: str):
        self.props = {}
        for prop in text.split(" "):
            key, value = prop.split(":")
            self.props[key] = value

    def valid(self, apply_rules: bool):
        if not REQUIRED_PROPS.issubset(self.props.keys()):
            return False

        # Only for part 2
        if not apply_rules:
            return True

        for v in [
            lambda: self.eval_height(),
            lambda: self.eval_eye_color(),
            lambda: self.eval_in_range(BIRTH_YEAR, 1920, 2002),
            lambda: self.eval_in_range(ISSUE_YEAR, 2010, 2020),
            lambda: self.eval_in_range(EXPIRATION_YEAR, 2020, 2030),
            lambda: self.eval_with_regex(HAIR_COLOR, r'^\#[0-9a-f]{6}$'),
            lambda: self.eval_with_regex(PASSPORT_ID, r'^\d{9}$'),
        ]:
            if not v():
                return False

        return True

    def eval_in_range(self, prop_name: str, lower: int, upper: int):
        val = self.props.get(prop_name)
        return lower <= int(val) <= upper

    def eval_with_regex(self, prop_name: int, regex):
        val = self.props.get(prop_name)
        return re.match(regex, val)

    def eval_height(self):
        val = self.props.get(HEIGHT)

        if "in" in val:
            val = val.replace("in", "")
            return 59 <= int(val) <= 76
        if "cm" in val:
            val = val.replace("cm", "")
            return 150 <= int(val) <= 193

        return False

    def eval_eye_color(self):
        val = self.props.get(EYE_COLOR)
        return val in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']


def get_passports():
    data = sys.stdin.read().strip()
    data = data.split("\n\n")
    data = [x.replace("\n", " ") for x in data]

    return [Passport(x) for x in data]


if __name__ == "__main__":
    passports = get_passports()

    # Part 1
    passports = list(filter(lambda x: x.valid(apply_rules=False), passports))
    print(f"Part 1 => {len(passports)}")

    # Part 2
    passports = list(filter(lambda x: x.valid(apply_rules=True), passports))
    print(f"Part 2 => {len(passports)}")
