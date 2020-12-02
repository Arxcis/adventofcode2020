#include <stdio.h>
#include <string.h>

int main() {
  const int MAX_LINE = 100;

  int valid_passwords = 0;
  int valid_passwords_part2 = 0;
  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ) {
    int from = 0;
    int to = 0;
    char letter = 0;
    char password[30];
    sscanf(line, "%d-%d %c: %s", &from, &to, &letter, password);

    int letter_occurances = 0;
    for (int i = 0; i < strlen(password); i++) {
      if (password[i] == letter) {
        letter_occurances += 1;
      }
    }

    if (letter_occurances >= from && letter_occurances <= to) {
      valid_passwords += 1;
    }

    int letter_occurances_part2 = 0;
    if (password[from-1] == letter) {
      letter_occurances_part2 += 1;
    }

    if (password[to-1] == letter) {
      letter_occurances_part2 += 1;
    }

    if (letter_occurances_part2 == 1) {
      valid_passwords_part2 += 1;
    }
  }

  printf("%d\n", valid_passwords);
  printf("%d\n", valid_passwords_part2);

  return 0;
}
