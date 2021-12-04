#include <iostream>
#include <map>

int main() {
  //Two ints that stores the answers we want
  int part1 = 0, part2 = 0;
  //Each line in the input
  std::string line;
  //Map of all input with index
  std::map<int, int> input;

  //Iterator for the index number
  int index = 0;
  //Read all input and insert into map
  while (std::getline(std::cin, line))
  {
    //   input.insert({++index, std::stoi(line)});
    input[++index] = std::stoi(line);
  }
  //Two bools so we can stop when we have our values
  bool first_value = false, second_value = false;
  //Loop through and compare, print the product when 2 factors equals 2020
  for (int i = 1; i <= input.size(); i++)
  {
      for (int  j = i + 1; j <= input.size(); j++)
      {
          if (input[i] + input[j] == 2020)
          {
              part1 = (input.at(i) * input.at(j));
              first_value = true;
          }
          //do another check to see if i, j and another factor, k, equal 2020
          for (int k = j + 1; k <= input.size(); k++)
          {
              if (input[i] + input[j] + input[k] == 2020   )
              {
                  part2 = (input.at(i) * input.at(j) * input.at(k));
                  second_value = true;
              }
          }
          if (first_value && second_value)
          {
              break;
          }
      }
  }
  std::cout << part1 << "\n" << part2 << std::endl;
  return 0;
}

