#!/usr/bin/env bash
set -e

# Usage:   ./languages/php.sh INPUT              OUTPUT             SOLUTION
# Example: ./languages/php.sh ./day-03/input.txt  ./day-03/input.txt ./day-03/solutions/main.php

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

cat $INPUT | php $SOLUTION | diff - $OUTPUT
echo "cat INPUT | php $SOLUTION ✅"
