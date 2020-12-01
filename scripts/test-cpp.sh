#!/usr/bin/env bash
set -e

# Usage:   ./test-cpp.sh INPUT              OUTPUT             SOLUTION
# Example: ./test-cpp.sh /day-03/input.txt  /day-03/input.txt  /day-03/solutions/main.cpp

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
OUT="/tmp/aoc2020.g++.out"

g++ $SOLUTION -o $OUT;
cat $INPUT | $OUT | diff - $OUTPUT
rm $OUT;
echo "cat INPUT | g++ $SOLUTION ✅"
