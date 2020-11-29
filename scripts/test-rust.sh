#!/usr/bin/env bash
set -e

# Usage:   ../test-py.sh DIR                      SOLUTION
# Example: ../test-py.sh "/adventofcode2020/day-03" "solutions/main.rs"

DIR="$1"
SOLUTION="$2"
OUT="rustc.out"

rustc "$DIR/$SOLUTION" -o "$DIR/$OUT"
cat "$DIR/input.txt" | "$DIR/$OUT" | diff - "$DIR/output.txt"
rm "$DIR/$OUT"
echo "$DIR / rustc $SOLUTION -o $OUT && ./$OUT ✅"
