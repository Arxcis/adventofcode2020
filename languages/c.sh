#!/usr/bin/env bash
set -e

# Usage:   ./languages/c.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/c.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.c

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
OUT="/tmp/aoc2020.gcc.out"

gcc $SOLUTION -o $OUT;
cat $INPUT | $OUT | diff - $OUTPUT
rm $OUT;
echo "cat INPUT | gcc $SOLUTION ✅"
