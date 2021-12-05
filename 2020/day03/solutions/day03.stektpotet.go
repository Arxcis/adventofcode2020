package main

import (
	"bufio"
	"fmt"
	"os"
)

type slope struct {
	right int
	down int
}

func CountTrees(lines []string, move slope) int {
	count := 0
	for y, line := range lines {
		if y % move.down == 0 {
			x := ((y / move.down) * move.right) % len(line)
			if line[x] == '#' {
				count++
			}
		}
	}
	return count
}

func main() {
	// Initialization and input reading
	scanner := bufio.NewScanner(bufio.NewReader(os.Stdin))
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	slopes := []slope{
		{right: 1, down:  1},
		{right: 3, down:  1},
		{right: 5, down:  1},
		{right: 7, down:  1},
		{right: 1, down:  2},
	}
	sums := make([]int, 5, 5)

	// Count the encountered trees using the different slopes
	for i, s := range slopes {
		sums[i] = CountTrees(lines, s)
	}

	prod := 1
	for _, s := range sums {
		prod *= s
	}

	fmt.Println(sums[1])
	fmt.Println(prod)

}