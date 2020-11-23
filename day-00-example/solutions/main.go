package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	var sumAll int64 = 0
	var sumOdd int64 = 0
	for scanner.Scan() {
		line := scanner.Text()
		num, _ := strconv.ParseInt(line, 10, 64)
		sumAll += num

		if num%2 != 0 {
			sumOdd += num
		}
	}

	fmt.Println(sumAll)
	fmt.Println(sumOdd)
}
