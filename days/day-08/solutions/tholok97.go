package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

type instruction struct {
	arg int
	op  string
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	instructions := make([]instruction, 0)

	for scanner.Scan() {
		line := scanner.Text()

		re := regexp.MustCompile(`^(nop|acc|jmp) ([+-]\d+)$`)
		matches := re.FindStringSubmatch(line)

		arg, err := strconv.Atoi(matches[2])

		if err != nil {
			panic("Misbehaving number")
		}

		instructions = append(instructions, instruction{
			op:  matches[1],
			arg: arg,
		})
	}

	_, accumulator := run(instructions)

	fmt.Println(accumulator)

	for i := 0; i < len(instructions); i++ {
		swap := instructions[i].op

		switch swap {
		case "jmp":
			instructions[i].op = "nop"
		case "nop":
			instructions[i].op = "jmp"
		default:
			continue
		}

		isInfinite, accumulator := run(instructions)

		if !isInfinite {
			fmt.Println(accumulator)
            break
		}

		instructions[i].op = swap
	}
}

func run(instructions []instruction) (isinfinite bool, accumulator int) {
	curr := 0

	visited := make([]bool, len(instructions))

	for {
		if curr == len(instructions) {
			return false, accumulator
		}

		if visited[curr] {
			return true, accumulator
		}

		visited[curr] = true

		ins := instructions[curr]

		switch ins.op {
		case "acc":
			accumulator += ins.arg
			curr++
		case "nop":
			curr++
		case "jmp":
			curr += ins.arg
		}
	}
}
