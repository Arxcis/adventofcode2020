#!/usr/bin/env bash
set -euo pipefail

# Usage:   ../../languages/deno.sh INPUT     OUTPUT     SOLUTION
# Example: ../../languages/deno.sh input.txt output.txt solutions/day03.ts

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

start=$(($(date +%s%N)/1000000))
cat $INPUT | deno run -q $SOLUTION | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "deno" "$TIME" "$SOLUTION"
