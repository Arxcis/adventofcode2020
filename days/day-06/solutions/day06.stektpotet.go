package main

import (
  "bufio"
  "bytes"
  "fmt"
  "os"
  "strings"
)

func onNewBatch(data []byte, atEOF bool) (advance int, token []byte, err error) {
  if atEOF && len(data) == 0 {
    return 0, nil, nil
  }
  // iteratively find instances of double new line, and advance to the next batch
  // (skip 4 bytes ahead past double newline)
  if i := bytes.Index(data, []byte{13, 10, 13, 10}); i >= 0 {
    return i + 4, data[0:i], nil
  }
  // If we're at EOF, we have a final, non-terminated line. Return it.
  if atEOF {
    return len(data), data, nil
  }
  // Request more data.
  return 0, nil, nil
}

func main() {
  scanner := bufio.NewScanner(os.Stdin)
  scanner.Split(onNewBatch)
  anyCount:=0
  everyCount:=0
  for scanner.Scan() {
    groupAnswers := strings.Fields(scanner.Text())
    c := make(map[rune]int, len(groupAnswers))
    for _, ans := range groupAnswers {
      for _, k := range ans {
        c[k]++
      }
    }
    anyCount += len(c)
    for _, v := range c {
      if v == len(groupAnswers) {
        everyCount++
      }
    }
  }
  fmt.Printf("%v\n%v\n", anyCount, everyCount)
}
