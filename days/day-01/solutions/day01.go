package main

import (
  "bufio"
  "fmt"
  "os"
  "strconv"
)

func main() {
  var nums []int
  reader := bufio.NewReader(os.Stdin)

  scanner := bufio.NewScanner(reader)
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
        if j == j+k {
          continue
        }
        if a+b+c == 2020 {
          fmt.Println(a * b * c)
        }
      }
    }
  }
}
