#!/usr/bin/env bash
set -e

# Usage:   ./languages/go.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/go.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.go

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | go run $SOLUTION | diff - $OUTPUT
echo "cat INPUT | go run $SOLUTION ✅"
