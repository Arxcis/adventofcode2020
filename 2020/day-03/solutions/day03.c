#include <stdio.h>
#include <string.h>

const int MAX_LINE = 100;
const char TREE = '#';

struct Toboggan {
  int x;
  int trees_hit;
  const int right;
  const int down;
};

// Declare a bunch of toboggans (sleighs)
const int TOBOGGANS_SIZE = 5;
struct Toboggan toboggans[5] = {
  { .x = 0, .right = 3, .down = 1, .trees_hit = 0 },
  { .x = 0, .right = 1, .down = 1, .trees_hit = 0 },
  { .x = 0, .right = 5, .down = 1, .trees_hit = 0 },
  { .x = 0, .right = 7, .down = 1, .trees_hit = 0 },
  { .x = 0, .right = 1, .down = 2, .trees_hit = 0 },
};

int main() {
  // Ignore start-line
  char line[MAX_LINE];
  fgets(line, MAX_LINE, stdin);
  const int WRAP_WIDTH = strlen(line) - 1;

  // Read line by line starting from line 1
  int y = 1;
  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ++y) {

    for (int i = 0; i < TOBOGGANS_SIZE; ++i) {
      struct Toboggan* toboggan = &toboggans[i];

      // Skip current line, for this specific toboggan, if...
      if (y % toboggan->down != 0) {
        continue;
      }

      toboggan->x = (toboggan->x + toboggan->right) % WRAP_WIDTH;
      toboggan->trees_hit = toboggan->trees_hit + (line[toboggan->x] == TREE);
    }
  }

  long int tree_product = 1;
  for (int i = 0; i < TOBOGGANS_SIZE; ++i) {
      tree_product = tree_product * toboggans[i].trees_hit;
  }

  printf("%d\n", toboggans[0].trees_hit);
  printf("%ld\n", tree_product);

  return 0;
}
