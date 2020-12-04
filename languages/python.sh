#!/usr/bin/env bash
set -euo pipefail

# Usage:   ./languages/python.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/python.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.py

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

start=$(($(date +%s%N)/1000000))
cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "python3" "$TIME" "$SOLUTION"
