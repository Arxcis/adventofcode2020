package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	file, _ := os.Open("input")
	defer file.Close()

	var nums []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		i, _ := strconv.Atoi(scanner.Text())
		nums = append(nums, i)
	}

	for i, a := range nums {
		for j, b := range nums[i:] {
			if i == i+j {
				continue
			}
			if a+b == 2020 {
				fmt.Println(a * b)
			}
		}
	}

	for i, a := range nums {
		for j, b := range nums[i:] {
			if i == i+j {
				continue
			}
			for k, c := range nums[i+j:] {
				if i == i+j+k {
					continue
				}
				if a+b+c == 2020 {
					fmt.Println(a * b * c)
				}
			}
		}
	}
}