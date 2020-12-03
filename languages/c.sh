#!/usr/bin/env bash
set -e

# Usage:   ./languages/c.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/c.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.c

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
OUT="$(mktemp)"

gcc $SOLUTION -o $OUT;

start=$(($(date +%s%N)/1000000))
cat $INPUT | $OUT | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print.sh "gcc" "$TIME" "$SOLUTION"

rm $OUT;
