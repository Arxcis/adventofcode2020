package main

import (
	"bufio"
	"fmt"
	"os"
)

// treeRow is an endlessly repeating pattern of trees.
type treeRow struct {
	// true == tree
	// otherwise not tree
	trees []bool
}

// is there a tree at position x, counting from left to right?
func (r treeRow) tree(x int) bool {
	x %= len(r.trees)

	return r.trees[x]
}

func newTreeRow(s string) treeRow {
	trees := make([]bool, len(s))

	for i, c := range s {
		var tree bool

		switch string(c) {
		case "#":
			tree = true
		case ".":
			tree = false
		default:
			panic("unknown map thingy")
		}

		trees[i] = tree
	}

	return treeRow{
		trees: trees,
	}
}

func main() {
	forest := make([]treeRow, 0)

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		forest = append(forest, newTreeRow(scanner.Text()))
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}

	fmt.Println(slopeCheck(forest, 3, 1))
	fmt.Println(multiply(
		slopeCheck(forest, 1, 1),
		slopeCheck(forest, 3, 1),
		slopeCheck(forest, 5, 1),
		slopeCheck(forest, 7, 1),
		slopeCheck(forest, 1, 2),
	))
}

func multiply(nums ...int) int {
	if len(nums) == 0 {
		return 0
	}

	res := nums[0]

	if len(nums) == 1 {
		return res
	}

	for _, num := range nums[1:] {
		res *= num
	}

	return res
}

// returns number of trees along given slope.
func slopeCheck(forest []treeRow, slopeRight, slopeDown int) int {
	posX := 0
	posY := 0

	seenTrees := 0

	for posY < len(forest) {

		tree := forest[posY].tree(posX)

		if tree {
			seenTrees++
		}

		posX += slopeRight
		posY += slopeDown
	}

	return seenTrees
}
