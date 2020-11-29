#!/bin/bash
set -e

# Usage:   ../test-go.sh DIR                      SOLUTION
# Example: ../test-go.sh /adventofcode2020/day-03 solutions/main.go

DIR="$1"
SOLUTION="$2"

cat "$DIR/input.txt" | go run "$DIR/$SOLUTION" | diff - "$DIR/output.txt"
echo "$DIR / go run $SOLUTION ✅"
