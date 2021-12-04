#include <stdio.h>

int main() {
  int sum_all = 0;
  int sum_odd = 0;
  const int MAX_LINE = 100;

  for (char line[MAX_LINE]; fgets(line, MAX_LINE, stdin); ) {
    int num = 0;
    sscanf(line, "%d", &num);
    sum_all += num;
    sum_odd += (num % 2 == 1) ? num : 0;
  }

  printf("%d\n", sum_all);
  printf("%d\n", sum_odd);

  return 0;
}
