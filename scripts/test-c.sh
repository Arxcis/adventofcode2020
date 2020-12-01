#!/usr/bin/env bash
set -e

# Usage:   ./test-c.sh INPUT              OUTPUT             SOLUTION
# Example: ./test-c.sh /day-03/input.txt  /day-03/input.txt  /day-03/solutions/main.c

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
OUT="/tmp/aoc2020.gcc.out"

gcc $SOLUTION -o $OUT;
cat $INPUT | $OUT | diff - $OUTPUT
rm $OUT;
echo "cat INPUT | gcc $SOLUTION ✅"
