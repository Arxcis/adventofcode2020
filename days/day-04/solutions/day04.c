#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const int MAX_STRING = 100;

const int FLAG_BYR = 0b00000001;
const int FLAG_IYR = 0b00000010;
const int FLAG_EYR = 0b00000100;
const int FLAG_HGT = 0b00001000;
const int FLAG_HCL = 0b00010000;
const int FLAG_ECL = 0b00100000;
const int FLAG_PID = 0b01000000;
const int ALL_FLAGS = FLAG_BYR|FLAG_IYR|FLAG_EYR|FLAG_HGT|FLAG_HCL|FLAG_ECL|FLAG_PID;
const int NO_FLAGS = 0b0;

const int REQUIRED_KEYS_SIZE = 7;
const char REQUIRED_KEYS[7][4] = {
  {'b','y','r', '\0'}, // Birth year
  {'i','y','r', '\0'}, // issue year
  {'e','y','r', '\0'}, // expiration year
  {'h','g','t', '\0'}, // height
  {'h','c','l', '\0'}, // hair color
  {'e','c','l', '\0'}, // eye color
  {'p','i','d', '\0'}, // passportID
  // {'c','i','d', '\0'}, // countryID OPTIONAL!
};

int main() {

  // Passport valid until opposite is proven
  int required_key_flags = 0;
  int valid_value_flags = 0;

  int passports_with_all_required_keys = 0;
  int passports_with_all_valid_values = 0;

  for (char line[MAX_STRING]; fgets(line, MAX_STRING, stdin);) {

    // If we are on a new-line, it means that we are ready to check if the passport was valid
    if (strlen(line) == 1) {
      passports_with_all_required_keys += required_key_flags == ALL_FLAGS;
      passports_with_all_valid_values += valid_value_flags == ALL_FLAGS;

      required_key_flags = NO_FLAGS;
      valid_value_flags = NO_FLAGS;
      continue;
    }


    // Count required keys


    // Go through all tokens on line
    char* end_token;
    for (
      char* token = strtok_r(line, " ", &end_token);
      token != NULL;
      token = strtok_r(NULL, " ", &end_token)
    ) {
      char* end_key_value;
      char* key = strtok_r(token, ":", &end_key_value);
      char* value = strtok_r(NULL, ":", &end_key_value);

      //
      // 1. Set flag, if key is one of the required keys
      //
      for (int i = 0; i < REQUIRED_KEYS_SIZE; ++i) {
        const char* required_key = REQUIRED_KEYS[i];
        if (strcmp(required_key, key) == 0) {
          required_key_flags |= (1 << i);
          break;
        }
      }

      //
      // 2. Set flag, if value is valid
      //

      // byr (Birth Year) - four digits; at least 1920 and at most 2002.
      if (strcmp(key, "byr") == 0) {
        if (strlen(value) == 4) {
          char * end;
          long number = strtol(value, &end, 10);
          if (value != end) {
            if (number >= 1920 && number <= 2002) {
              valid_value_flags |= FLAG_BYR;
            }
          }
        }
      }
      // iyr (Issue Year) - four digits; at least 2010 and at most 2020.
      else if (strcmp(key, "iyr") == 0) {
        if (strlen(value) == 4) {
          char * end;
          long number = strtol(value, &end, 10);
          if (value != end) {
            if (number >= 2010 && number <= 2020) {
              valid_value_flags |= FLAG_IYR;
            }
          }
        }
      }
      // eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
      else if (strcmp(key, "eyr") == 0) {
        if (strlen(value) == 4) {
          char * end;
          long number = strtol(value, &end, 10);
          if (value != end) {
            if (number >= 2020 && number <= 2030) {
              valid_value_flags |= FLAG_EYR;
            }
          }
        }
      }
      // hgt (Height) - a number followed by either cm or in:
      // If cm, the number must be at least 150 and at most 193.
      // If  in, the number must be at least 59 and at most 76.
      else if (strcmp(key, "hgt") == 0) {
        valid_value_flags |= (1 << 3);
      }
      // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
      else if (strcmp(key, "hcl") == 0) {
        valid_value_flags |= (1 << 4);
      }
      // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
      else if (strcmp(key, "ecl") == 0) {
        valid_value_flags |= (1 << 5);
      }
      // pid (Passport ID) - a nine-digit number, including leading zeroes.
      else if (strcmp(key, "pid") == 0) {
        if (strlen(value) == 9) {
          valid_value_flags |= (1 << 6);
        }
      } else {
        printf("%s\n", key);
      }
    }
  }

  // Count the last passport if it was valid
  passports_with_all_required_keys += required_key_flags == ALL_FLAGS;
  passports_with_all_valid_values += valid_value_flags == ALL_FLAGS;

  printf("%d\n", passports_with_all_required_keys);
  printf("%d\n", passports_with_all_valid_values);

  return 0;
}
