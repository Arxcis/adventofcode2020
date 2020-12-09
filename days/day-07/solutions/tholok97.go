package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

type pair struct {
	amount int
	color  string
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	rules := make(map[string][]pair)

	for scanner.Scan() {
		ruleString := scanner.Text()
		color, contained := parseRule(ruleString)
		rules[color] = contained
	}

	sum := 0

	for key := range rules {
		if contains(rules, key, "shiny gold") {
			sum++
		}
	}

	fmt.Println(sum)

	// subtract one cost as we care about the cost of the bags **within** the
	// initial bag
	fmt.Println(colorCost(rules, "shiny gold") - 1)
}

func parseRule(s string) (color string, contained []pair) {
	reBagColor := regexp.MustCompile(`^([\w ]*) bags contain`)
	reBagColorMatches := reBagColor.FindStringSubmatch(s)
	color = reBagColorMatches[1]
	reNoOther := regexp.MustCompile(`no other bags`)

	if reNoOther.MatchString(s) {
		// No bags are contained, return early
		return color, make([]pair, 0)
	}

	reBagContains := regexp.MustCompile(`(,? (\d+) ([\w ]*) bags?)`)
	reBagContainsMatches := reBagContains.FindAllStringSubmatch(s, -1)
	contained = make([]pair, len(reBagContainsMatches))

	for i, matches := range reBagContainsMatches {
		amount, err := strconv.Atoi(matches[2])

		if err != nil {
			panic("misbehaving number string >:(")
		}

		contained[i] = pair{
			amount: amount, // don't care about this one
			color:  matches[3],
		}
	}

	return color, contained
}

// does 'color' contain 'target'?
// assume X can't contain X
func contains(rules map[string][]pair, color, target string) bool {
	for _, contained := range rules[color] {
		if contained.color == target {
			return true
		}

		if contains(rules, contained.color, target) {
			return true
		}
	}
	return false
}

// what's the total cost of 'color'?
func colorCost(rules map[string][]pair, color string) int {
	// myself
	cost := 1

	for _, contained := range rules[color] {
		// + the cost of each of my bags
		cost += contained.amount * colorCost(rules, contained.color)
	}

	return cost
}
