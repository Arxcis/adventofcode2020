#include <stdio.h>
#define TRUE 1
#define FALSE 0

const int MAX_LINE_WIDTH = 100;

int main() {
  char line[MAX_LINE_WIDTH];
  int num = 0;
  int sum_all = 0;
  int sum_odd = 0;

  int reading = TRUE;
  while (reading) {
    fgets(line, MAX_LINE_WIDTH, stdin);
    if (feof(stdin) || line[0] == '\n') {
      reading = FALSE;
      continue;
    }

    sscanf(line, "%d", &num);
    sum_all += num;
    sum_odd += (num % 2 != 0) ? num : 0;
  }

  printf("%d\n", sum_all);
  printf("%d\n", sum_odd);
  return 0;
}
