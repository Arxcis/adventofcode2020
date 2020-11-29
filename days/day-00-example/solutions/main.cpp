#include <iostream>

int main() {
  int sum_all = 0;
  int sum_odd = 0;

  for (std::string line; std::getline(std::cin, line);) {
    if (line == "\n") {
      continue;
    }

    const int num = std::stoi(line);
    sum_all += num;
    sum_odd += (num % 2 != 0) ? num : 0;
  }

  std::cout
    << sum_all << std::endl
    << sum_odd << std::endl;

  return 0;
}
