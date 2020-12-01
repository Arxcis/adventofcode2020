#include <stdio.h>

int main() {
  const int MAX_LINE = 100;

  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ) {
    int num = 0;
    sscanf(line, "%d", &num);
    printf("%d", num);
  }

  return 0;
}
