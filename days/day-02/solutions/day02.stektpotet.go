package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(bufio.NewReader(os.Stdin))
	valid_count, valid_xor := 0, 0
	for scanner.Scan() {
		values := strings.Split(scanner.Text(), " ")
		char, pass := values[1][:len(values[1])-1], values[2]
		limits := strings.Split(values[0], "-")
		lim1, _ := strconv.Atoi(limits[0])
		lim2, _ := strconv.Atoi(limits[1])

		if lim1 <= strings.Count(pass, char) && strings.Count(pass, char) <= lim2 {
			valid_count ++
		}
		if (pass[lim1-1:lim1] == char) != (pass[lim2-1:lim2] == char) {
			valid_xor ++
		}
	}
	fmt.Print(valid_count, "\n", valid_xor, "\n")
}