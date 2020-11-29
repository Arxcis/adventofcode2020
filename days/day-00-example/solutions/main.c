#include <stdio.h>

const int MAX_LINE_WIDTH = 100;

int main() {
  char line[MAX_LINE_WIDTH];
  int num = 0;
  int sum_all = 0;
  int sum_odd = 0;

  for (;;) {
    fgets(line, MAX_LINE_WIDTH, stdin);
    if (feof(stdin)) {
      break;
    }

    sscanf(line, "%d", &num);
    sum_all += num;
    sum_odd += (num % 2 != 0) ? num : 0;
  }

  printf("%d\n", sum_all);
  printf("%d\n", sum_odd);
  return 0;
}
