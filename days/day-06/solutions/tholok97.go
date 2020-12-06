package main

import (
	"bufio"
	"fmt"
	"os"
)

type group struct {
	count   int
	answers map[rune]int
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	// initialize with one group, the 'curr' group
	groups := make([]group, 1)
	curr := 0

	groups[curr] = group{
		count:   0,
		answers: make(map[rune]int),
	}

	for scanner.Scan() {
		answers := scanner.Text()
		if answers == "" {
			curr++

			groups = append(groups, group{
				count:   0,
				answers: make(map[rune]int),
			})

			continue
		}

		groups[curr].count++

		for _, c := range answers {
			_, ok := groups[curr].answers[c]

			if !ok {
				groups[curr].answers[c] = 1

				continue
			}

			groups[curr].answers[c]++
		}
	}

	sumYes := 0
	sumAllYes := 0

	for _, group := range groups {
		sumYes += len(group.answers)

		for _, count := range group.answers {
			if count == group.count {
				sumAllYes++
			}
		}
	}

	fmt.Println(sumYes)
	fmt.Println(sumAllYes)
}
