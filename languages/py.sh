#!/usr/bin/env bash
set -e

# Usage:   ./languages/py.sh INPUT              OUTPUT             SOLUTION
# Example: ./languages/py.sh ./day-03/input.txt ./day-03/output.txt ./day-03/solutions/main.py

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
echo "cat INPUT | python3 $SOLUTION ✅"
