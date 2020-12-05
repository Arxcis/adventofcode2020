package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

type numbers struct {
	first  int
	second int
}

type policy struct {
	number    numbers
	character string
}

type policyPasswordPair struct {
	policy   policy
	password string
}

func main() {

	pairs := make([]policyPasswordPair, 0)

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		re := regexp.MustCompile(`(\d+)-(\d+) (\w): (\w+)`)
		matches := re.FindStringSubmatch(scanner.Text())

		lower, err := strconv.Atoi(matches[1])
		requireNoErr(err)

		upper, err := strconv.Atoi(matches[2])
		requireNoErr(err)

		pairs = append(pairs, policyPasswordPair{
			policy: policy{
				number: numbers{
					first:  lower,
					second: upper,
				},
				character: matches[3],
			},
			password: matches[4],
		})
	}

	if scanner.Err() != nil {
		panic("failed to scan")
	}

	fmt.Println(verify(pairs, validAtSledRentalPlace))
	fmt.Println(verify(pairs, validAtToboggan))
}

func verify(pairs []policyPasswordPair, corporatePolicyVerfier func(policy, string) bool) int {

	validCount := 0

	for _, pair := range pairs {
		if corporatePolicyVerfier(pair.policy, pair.password) {
			validCount++
		}
	}

	return validCount
}

func validAtSledRentalPlace(policy policy, password string) bool {
	policyChar := policy.character
	count := strings.Count(password, policyChar)

	if count < policy.number.first {
		return false
	}

	if count > policy.number.second {
		return false
	}

	return true
}

func validAtToboggan(policy policy, password string) bool {
	policyChar := policy.character
	firstChar := string(password[policy.number.first-1])
	secondChar := string(password[policy.number.second-1])

	switch {
	case firstChar == policyChar && secondChar == policyChar:
		return false
	case firstChar == policyChar:
		return true
	case secondChar == policyChar:
		return true
	}

	return false
}

func requireNoErr(err error) {
	if err != nil {
		panic(err)
	}
}
