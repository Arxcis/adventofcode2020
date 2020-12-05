package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {

	var report []float64

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		entry, err := strconv.ParseFloat(scanner.Text(), 64)
		if err != nil {
			panic("failed to parsefloat")
		}
		report = append(report, entry)
	}

	if scanner.Err() != nil {
	    panic("failed to scan")
	}

	for i := range report {
		for j := i+1; j < len(report); j++ {
			a := report[i]		
			b := report[j]
			if a + b == 2020 {
				// Part 1
				fmt.Println(int64(a * b))
			}
		}
	}

	for i := range report {
		for j := i+1; j < len(report); j++ {
			for k := j+1; k < len(report); k++ {
				a := report[i]		
				b := report[j]
				c := report[k]
				if a + b + c == 2020 {
					fmt.Println(int64(a * b * c))
				}
			}
		}
	}
}
