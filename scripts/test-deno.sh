#!/bin/bash
set -e

# Usage:   ../test-deno.sh DIR                      SOLUTION
# Example: ../test-deno.sh /adventofcode2020/day-03 solution/main.deno.ts

DIR="$1"
SOLUTION="$2"

cat "$DIR/input" | deno run "$DIR/$SOLUTION" | diff - "$DIR/output"
echo "$DIR / deno run $SOLUTION ✅"
