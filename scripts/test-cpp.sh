#!/bin/bash
set -e

# Usage:   ../test-cpp.sh DIR     SOLUTION
# Example: ../test-cpp.sh /day-03 solutions/main.cpp

DIR="$1"
SOLUTION="$2"
OUT="g++.out"

g++ "$DIR/$SOLUTION" -o "$DIR/$OUT";
cat "$DIR/input.txt" | "$DIR/$OUT" | diff - "$DIR/output.txt"
rm "$DIR/$OUT";
echo "$DIR / g++ $SOLUTION -o $OUT && ./$OUT ✅"
