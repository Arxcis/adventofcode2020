#include <stdio.h>
#include <string.h>

#define MAX_LINE 100
#define LETTERS_IN_ALPHABET 26
#define SMALL_ALPHABET_ASCII_OFFSET 97

//                     0babcdefghijklmnopqrstuvwxyz
#define RESET_NO_BITS  0b00000000000000000000000000;
#define RESET_ALL_BITS 0b11111111111111111111111111;

int main() {
  int letters_someone__answered = RESET_NO_BITS;
  int letters_everyone_answered = RESET_ALL_BITS;
  int someone__answered_count = 0;
  int everyone_answered_count = 0;

  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ) {
    // If we are on a new-line, it means that we are finished with a group.
    if (strlen(line) == 1) {
      // Time to count bits
      for (int i = 0; i < LETTERS_IN_ALPHABET; ++i) {
        someone__answered_count += (letters_someone__answered & (1 << i)) != 0;
        everyone_answered_count += (letters_everyone_answered & (1 << i)) != 0;
      }

      letters_someone__answered = RESET_NO_BITS;
      letters_everyone_answered = RESET_ALL_BITS;
      continue;
    }

    int letters = RESET_NO_BITS;
    for (int c = 0; c < strlen(line) - 1; c++) {
      // Shift from  'a' <= ch <= 'z' to '0' <= ch <= '25'
      char letter = line[c] - SMALL_ALPHABET_ASCII_OFFSET;
      letters |= (1 << letter);
    }
    letters_someone__answered |= letters;
    letters_everyone_answered &= letters;
  }

  // Count bits on last time
  for (int i = 0; i < LETTERS_IN_ALPHABET; ++i) {
    someone__answered_count += (letters_someone__answered & 1 << i) != 0;
    everyone_answered_count += (letters_everyone_answered & 1 << i) != 0;
  }

  printf("%d\n", someone__answered_count);
  printf("%d\n", everyone_answered_count);
}
