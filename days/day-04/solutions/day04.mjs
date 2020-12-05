import { readFileSync } from "fs";

const STANDARD_IN = 0
const lines = readFileSync(STANDARD_IN)
  .toString();

const passportStrings = [...lines.matchAll(/\S+([ \n][\S]+)*/g)]
  .map(([match]) => match);

const passportTokens = passportStrings
  .map(pass => pass.replaceAll(/\n/g, " ").split(" "))

const passportKeyValues = passportTokens
  .map(tokens => tokens.map(token => token.split(":")))

const REQUIRED_VALIDATORS = {
  //  byr (Birth Year) - four digits; at least 1920 and at most 2002.
  byr: (value) => !!value.match(/[\d]{4}/)
    && 1920 <= parseInt(value) && parseInt(value) <= 2002
  ,

  //  iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  iyr: (value) => !!value.match(/[\d]{4}/)
    && 2010 <= parseInt(value) && parseInt(value) <= 2020
  ,

  //  eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  eyr: (value) => !!value.match(/[\d]{4}/)
    && 2020 <= parseInt(value) && parseInt(value) <= 2030
  ,

  //  hgt (Height) - a number followed by either cm or in:
  //  If cm, the number must be at least 150 and at most 193.
  //  If in, the number must be at least 59 and at most 76.
  hgt: (value) => {
    const [,num, unit] = value.match(/(\d\d\d?)(in|cm)/) ?? [];
    if (!num) return false;

    const number = parseInt(num);

    return (unit === "cm" && 150 <= number && number <= 193)
      || (unit === "in" && 59 <= number && number <= 76);
  },

  //  hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  hcl: (value) => !!value.match(/#[a-z0-9]{6}/),

  //  ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  ecl: (value) => !!value.match(/amb|blu|brn|gry|grn|hzl|oth/),

  // pid (Passport ID) - a nine-digit number, including leading zeroes.
  pid: (value) => value.length === 9 && !!value.match(/[0]*[1-9][0-9]*/),
};

const REQUIRED_KEYS = Object.keys(REQUIRED_VALIDATORS);

const [part1, part2] = passportKeyValues
  .reduce(([part1, part2], keyValues) => {
    const requiredKeyValues = keyValues
      .filter(([key]) => REQUIRED_KEYS.includes(key))

    const keys = requiredKeyValues
      .map(([key]) => key)

    const keySet = [...new Set(keys)];

    const passportKeysAreValid = REQUIRED_KEYS
      .every(key => keySet.includes(key));

    const passportValuesAreValid = passportKeysAreValid &&
      requiredKeyValues
        .every(([key, value]) => (REQUIRED_VALIDATORS[key])?.(value));

    return [
      part1 + passportKeysAreValid,
      part2 + passportValuesAreValid
    ];
  }, [0,0])

console.log(`${part1}`);
console.log(`${part2}`);
