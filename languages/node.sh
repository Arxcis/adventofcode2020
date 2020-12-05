#!/usr/bin/env bash
set -euo pipefail

# Usage:   ./languages/node.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/node.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.mjs

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

start=$(($(date +%s%N)/1000000))
cat $INPUT | node --harmony-top-level-await $SOLUTION | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "node" "$TIME" "$SOLUTION"
