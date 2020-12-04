#include <stdio.h>
#include <string.h>

const int MAX_LINE = 100;


const int INVALID = 0;
const int VALID = 1;

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
  int required_key_count = 0;
  int valid_passport_count = 0;
  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin);) {

    // If we are on a new-line, it means that we are ready to check if the passport was valid
    if (strlen(line) == 1) {
      if (required_key_count == REQUIRED_KEYS_SIZE) {
        printf("VALID PASSPORT FOUND\n");
        valid_passport_count += 1;
      }
      required_key_count = 0;
      continue;
    }

    printf("%lu\n", strlen(line));

    for (int i = 0; i < REQUIRED_KEYS_SIZE; ++i) {
      const char* key = REQUIRED_KEYS[i];
      if (strstr(line, key) != NULL) {
        required_key_count += 1;
        printf("found key %s: count %d:\n", key, required_key_count);
      }
    }
  }

  // Count the last passport if it was valid
  if (required_key_count == REQUIRED_KEYS_SIZE) {
    valid_passport_count += 1;
  }

  printf("%d\n", valid_passport_count);
  //printf("%ld\n", tree_product);

  return 0;
}
