#!/bin/bash
set -e

# Usage:   ./test-bash.sh DIR     SOLUTION
# Example: ./test-bash.sh /day-03 solutions/main.bash

DIR="$1"
SOLUTION="$2"

cat "$DIR/input.txt" | bash "$DIR/$SOLUTION" | diff - "$DIR/output.txt"
echo "$DIR / bash $SOLUTION ✅"
