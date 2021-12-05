package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	passes := make([]string, 0)

	for scanner.Scan() {
		passes = append(passes, scanner.Text())
	}

	// Sort the passes so we can more predictably traverse through them. After
	// sorting, the passes will be decoded in decreasing order of rows, and
	// increasing order of columns
	sort.Strings(passes)

	max := 0
	mySeatID := 0
	prevCol := 0

	for _, pass := range passes {
		row, col := decode(pass)

		colDiff := col - prevCol

		if colDiff > 1 {
			mySeatID = seatID(row, col-1)
		}

		prevCol = col

		id := seatID(row, col)

		if id > max {
			max = id
		}
	}

	fmt.Println(max)
	fmt.Println(mySeatID)
}

func decode(boardingPass string) (row, column int) {
	rowLower := 0
	rowUpper := 127

	for _, c := range boardingPass[:7] {
		switch c {
		case 'F':
			rowUpper = rowLower + (rowUpper-rowLower)/2
		case 'B':
			rowLower = rowLower + (rowUpper-rowLower)/2 + 1
		default:
			panic("what??")
		}
	}

	if rowLower != rowUpper {
		panic("We messed up..")
	}

	colLower := 0
	colUpper := 7

	for _, c := range boardingPass[7:10] {
		switch c {
		case 'L':
			colUpper = colLower + (colUpper-colLower)/2
		case 'R':
			colLower = colLower + (colUpper-colLower)/2 + 1
		default:
			panic("Huh??")
		}
	}

	if colLower != colUpper {
		panic("Dammit")
	}

	return rowLower, colLower
}

func seatID(row, col int) int {
	return row*8 + col
}
