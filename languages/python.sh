#!/usr/bin/env bash
set -e

# Usage:   ./languages/python.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/python.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.py

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
echo "cat INPUT | python3 $SOLUTION ✅"
