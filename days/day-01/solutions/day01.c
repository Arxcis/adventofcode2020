#include <stdio.h>

int main() {
  const int LINE_SIZE = 200;
  int lines[LINE_SIZE];
  const int MAX_LINE = 100;

  int i = 0;
  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ) {
    int num = 0;
    sscanf(line, "%d", &num);
    lines[i++] = num;
  }

  long int doublet = 0;
  long int triplet = 0;

  for (int i = 0; i < LINE_SIZE; ++i) {
    for (int j = 0; j < LINE_SIZE; ++j) {

      if (((lines[i] + lines[j]) == 2020)) {
        doublet = lines[i] * lines[j];
      }

      for (int k = 0; k < LINE_SIZE; ++k) {
        if ((lines[i] + lines[j] + lines[k]) == 2020) {
          triplet = lines[i] * lines[j] * lines[k];
          break;
        }
      }
      if (doublet && triplet) {
        break;
      }
    }
    if (doublet && triplet) {
      break;
    }
  }

  printf("%ld\n", doublet);
  printf("%ld\n", triplet);

  return 0;
}
