from typing import Dict, Optional
import sys
import re


def bind_and_validate(byr: str, iyr: str, eyr: str, hgt: str, hcl: str, ecl: str, pid: str, cid: Optional[str] = None):
    # performing validation in what is assumed to be fastest to slowest order...
    if not (1920 <= int(byr) <= 2002) or not (2010 <= int(iyr) <= 2020) or not (2020 <= int(eyr) <= 2030):
        return False

    if not ecl in {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}:
        return False

    val = int(hgt[:-2]) if hgt[:-2] else 0
    low, high = {'cm': (150, 193), 'in': (59, 76)}.get(hgt[-2:], (1, 0))
    if not (low <= val <= high):
      return False

    if not re.search("^#[0-9a-f]{6}$", hcl) or not re.search("^[0-9]{9}$", pid):
        return False

    return True


def validate(passport: Dict[str, str]) -> (bool, bool):
    try:
        # First, try unpacking the passport dictionary. If this fails, immediately catch the exception
        # and consider the passport invalid.
        # If binding is successful, consider the field validation as long as 'field_validate' is set to True
        validated = bind_and_validate(**passport)
    except TypeError:  # Failed to bind dict keys as arguments
        return False, False
    # binding did not fail (requirement for task 1, validation is for task 2)
    return True, validated


entries = sys.stdin.read().split('\n\n')
num_bound, num_validated = 0, 0
for entry in entries:
    fields = entry.split()
    if len(fields) < 7:  # mini optimization - skip entries that clearly cannot be valid due to number of fields
        continue
    # all field identifiers are 3 in length, the rest (after the colon) is the field's value
    bound, validated = validate(passport={field[:3]: field[4:] for field in fields})
    num_bound += bound
    num_validated += validated
print(f'{num_bound}\n{num_validated}')
