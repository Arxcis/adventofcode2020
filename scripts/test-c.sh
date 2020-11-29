#!/bin/bash
set -e

# Usage:   ../test-c.sh DIR     SOLUTION
# Example: ../test-c.sh /day-03 solutions/main.c

DIR="$1"
SOLUTION="$2"
OUT="gcc.out"

gcc "$DIR/$SOLUTION" -o "$DIR/$OUT";
cat "$DIR/input.txt" | "$DIR/$OUT" | diff - "$DIR/output.txt"
rm "$DIR/$OUT";
echo "$DIR / gcc $SOLUTION -o $OUT && ./$OUT ✅"
