#!/bin/bash
set -e

# Usage:   ../test-node.sh DIR                      SOLUTION
# Example: ../test-node.sh /adventofcode2020/day-03 solution/main.node.mjs

DIR="$1"
SOLUTION="$2"

cat "$DIR/input" | node "$DIR/$SOLUTION" | diff - "$DIR/output"
echo "$DIR / node $SOLUTION ✅"
