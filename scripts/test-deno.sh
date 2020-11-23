#!/bin/bash
set -e

# Usage:   ../test-deno.sh DIR                      CMD
# Example: ../test-deno.sh /adventofcode2020/day-03 cmd/main.deno.ts

DIR="$1"
CMD="$2"

cat "$DIR/input" | deno run "$DIR/$CMD" | diff - "$DIR/output"
echo "$DIR / deno run $CMD ✅"
