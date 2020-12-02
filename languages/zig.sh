#!/usr/bin/env bash
set -e

# Usage:   ./languages/zig.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/zig.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.zig

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | zig run $SOLUTION | diff - $OUTPUT
echo "cat INPUT | zig $SOLUTION ✅"
