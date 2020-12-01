#!/usr/bin/env bash
set -e

# Usage:   ./languages/node.sh INPUT              OUTPUT             SOLUTION
# Example: ./languages/node.sh ./day-03/input.txt ./day-03/output.txt ./day-03/solutions/main.node.mjs

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | node $SOLUTION | diff - $OUTPUT
echo "cat INPUT | node $SOLUTION ✅"
