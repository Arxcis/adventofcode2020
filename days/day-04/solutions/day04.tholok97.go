package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

// validator is any function that can tell you if the given string is valid
// according to some criteria
type validator func(string) bool

// fieldValidators provides a validator for each key
type fieldValidators map[string]validator

func main() {
	passports := make([]map[string]string, 0)
	currPassport := make(map[string]string)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		s := scanner.Text()
		if s == "" {
			// new passport. Store current and reset currPassport
			passports = append(passports, currPassport)
			currPassport = make(map[string]string)

			continue
		}

		components := strings.Split(s, " ")

		for _, component := range components {
			re := regexp.MustCompile(`(\w{3}):(.+)`)
			match := re.FindStringSubmatch(component)

			name := match[1]
			value := match[2]
			currPassport[name] = value
		}
	}

	if len(currPassport) != 0 {
		passports = append(passports, currPassport)
	}

	fmt.Println(countValid(passports, fieldValidators{
		"byr": noopValidator,
		"iyr": noopValidator,
		"eyr": noopValidator,
		"hgt": noopValidator,
		"hcl": noopValidator,
		"ecl": noopValidator,
		"pid": noopValidator,
	}))

	fmt.Println(countValid(passports, fieldValidators{
		"byr": validByr,
		"iyr": validIyr,
		"eyr": validEyr,
		"hgt": validHgt,
		"hcl": validHcl,
		"ecl": validEcl,
		"pid": validPid,
	}))
}

func countValid(passports []map[string]string, fieldValidators fieldValidators) int {
	validCount := 0

	for _, passport := range passports {
		if valid(passport, fieldValidators) {
			validCount++
		}
	}

	return validCount
}

// valid validates given passport using given fieldValidators. A passport must
// contain fields for each key in fieldValidators
func valid(passport map[string]string, fieldValidators fieldValidators) bool {
	for fieldKey, valid := range fieldValidators {
		fieldValue, ok := passport[fieldKey]

		if !ok {
			return false
		}

		if !valid(fieldValue) {
			return false
		}
	}

	return true
}

func noopValidator(string) bool {
	return true
}

func validByr(value string) bool {
	if len(value) != 4 {
		return false
	}

	return validDigitInInterval(value, 1920, 2002)
}

func validIyr(value string) bool {
	if len(value) != 4 {
		return false
	}

	return validDigitInInterval(value, 2010, 2020)
}

func validEyr(value string) bool {
	if len(value) != 4 {
		return false
	}

	return validDigitInInterval(value, 2020, 2030)
}

func validHgt(value string) bool {
	re := regexp.MustCompile(`(\d+)(cm|in)`)
	matches := re.FindStringSubmatch(value)

	if len(matches) != 3 {
		return false
	}

	// default to cm min & max. Override to in min & max if appropriate
	hgtMin := 150
	hgtMax := 193

	if matches[2] == "in" {
		hgtMin = 59
		hgtMax = 76
	}

	if !validDigitInInterval(matches[1], hgtMin, hgtMax) {
		return false
	}

	return true
}

func validDigitInInterval(value string, lower, upper int) bool {
	digits, err := strconv.Atoi(value)

	if err != nil {
		return false
	}

	if digits < lower {
		return false
	}

	if digits > upper {
		return false
	}

	return true
}

func validHcl(value string) bool {
	re := regexp.MustCompile(`#[0-9a-f]{6}`)

	return re.MatchString(value)
}

func validEcl(value string) bool {
	re := regexp.MustCompile(`^(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)$`)

	return re.MatchString(value)
}

func validPid(value string) bool {
	if len(value) != 9 {
		return false
	}

	_, err := strconv.Atoi(value)

	if err != nil {
		return false
	}

	return true
}
