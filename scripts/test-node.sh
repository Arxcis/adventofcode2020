#!/usr/bin/env bash
set -e

# Usage:   ../test-node.sh DIR                      SOLUTION
# Example: ../test-node.sh /adventofcode2020/day-03 solutions/main.node.mjs

DIR="$1"
SOLUTION="$2"

cat "$DIR/input.txt" | node "$DIR/$SOLUTION" | diff - "$DIR/output.txt"
echo "$DIR / node $SOLUTION ✅"
