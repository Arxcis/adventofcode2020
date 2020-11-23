#!/bin/bash
set -e

# Usage:   ../test-py.sh DIR                      SOLUTION
# Example: ../test-py.sh /adventofcode2020/day-03 solution/main.py

DIR="$1"
SOLUTION="$2"

cat "$DIR/input" | python3 "$DIR/$SOLUTION" | diff - "$DIR/output"
echo "$DIR / python3 $SOLUTION ✅"
