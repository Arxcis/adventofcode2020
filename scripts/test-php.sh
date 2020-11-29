#!/usr/bin/env bash
set -e

# Usage:   ../test-php.sh DIR                      SOLUTION
# Example: ../test-php.sh /adventofcode2020/day-03 solutions/main.php

DIR="$1"
SOLUTION="$2"

cat "$DIR/input.txt" | php "$DIR/$SOLUTION" | diff - "$DIR/output.txt"
echo "$DIR / php $SOLUTION ✅"
