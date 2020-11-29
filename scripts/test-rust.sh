#!/bin/bash
set -e

# Usage:   ../test-py.sh DIR                      SOLUTION
# Example: ../test-py.sh "/adventofcode2020/day-03" "solutions/main.rs"

DIR="$1"
SOLUTION="$2"

rustc "$DIR/$SOLUTION" -o "$DIR/$SOLUTION.rustc"
cat "$DIR/input" | "$DIR/$SOLUTION.rustc" | diff - "$DIR/output"
rm "$DIR/$SOLUTION.rustc"
echo "$DIR / rustc $SOLUTION.rustc -o run && ./run ✅"
