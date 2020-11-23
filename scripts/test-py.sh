#!/bin/bash
set -e

# Usage:   ../test-py.sh DIR                      CMD
# Example: ../test-py.sh /adventofcode2020/day-03 cmd/main.py

DIR="$1"
CMD="$2"

cat "$DIR/input" | python3 "$DIR/$CMD" | diff - "$DIR/output"
echo "$DIR / python3 $CMD ✅"
