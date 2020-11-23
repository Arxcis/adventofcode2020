#!/bin/bash
set -e

# Usage:   ../test-go.sh DIR                      CMD
# Example: ../test-go.sh /adventofcode2020/day-03 cmd/main.go

DIR=$1
CMD=$2

cat "$DIR/input" | go run "$DIR/$CMD" | diff - "$DIR/output"
echo "$DIR / go run $CMD ✅"
