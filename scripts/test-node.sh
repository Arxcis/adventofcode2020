#!/bin/bash
set -e

# Usage:   ../test-node.sh DIR                      CMD
# Example: ../test-node.sh /adventofcode2020/day-03 cmd/main.node.mjs

DIR=$1
CMD=$2

cat "$DIR/input" | node "$DIR/$CMD" | diff - "$DIR/output"
echo "$DIR / node $CMD ✅"
