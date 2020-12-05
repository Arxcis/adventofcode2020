#include <iostream>
#include <cstring>
#include <sstream>

int main() {
  const int MAXLINELENGTH = 30;
  //Number of valid passwords
  int valid_passwords = 0;
  int acctually_valid_passwords = 0;
  //Each line in the input as string
  std::string line;
  while (std::getline(std::cin, line))
  {
    //Initialize needed variables per line.
    int lower_limit = 0, upper_limit = 0;
    char letter = 0, tmp = 0;
    char password[MAXLINELENGTH + 1];
    //Read the line as a stream into the different variables
    std::stringstream stringline(line);
    stringline >> lower_limit >> tmp >> upper_limit >> letter >> tmp >> password;
    //Count each time the letter occurs, starting at 0
    int letter_occurence = 0;
    for (int i = 0; i < strlen(password); i++)
    {
      if (password[i] == letter)
      {
        letter_occurence++;
      }
    }
    //If the letter occured more than lower limit, but less than high limit,
    //count up number of valid passwords. (inclusive limits)
    if (letter_occurence >= lower_limit && letter_occurence <= upper_limit)
    {
      valid_passwords += 1;
    }

    //Part 2
    if ((password[lower_limit - 1] == letter && password[upper_limit - 1] != letter) || (password[lower_limit - 1] != letter && password[upper_limit - 1] == letter))
    {
      acctually_valid_passwords++;
    }
  }
  std::cout << valid_passwords << "\n" << acctually_valid_passwords << std::endl;
  return 0;
}
