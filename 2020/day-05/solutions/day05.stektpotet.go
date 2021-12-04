package main

import (
	"bufio"
	"fmt"
	"os"
)

func toID(code string) int16 {
  id := int16(0)
  for i, r := range code {
    if r == 'B' || r=='R' {
      id |= (1 << uint(9-i))
    }
  }
  return id
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	min:=int16(9001)
	max:=int16(0)

	ids := make([]bool, 128*8)
	for scanner.Scan() {
	  id := toID(scanner.Text())
    if id < min {
      min = id
    } else if id > max {
      max = id
    }
    ids[id] = true
	}
	fmt.Println(max)
	for i := min; i < max; i++ {
	  //_, ok := ids[i]
	  if !ids[i] {
	    fmt.Println(i)
	    break
	  }
	}
}
