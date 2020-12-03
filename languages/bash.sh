#!/usr/bin/env bash
set -e

# Usage:   ./languages/bash.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/bash.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.bash

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"

start=$(($(date +%s%N)/1000000))
cat $INPUT | bash $SOLUTION | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"


D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "bash" "$TIME" "$SOLUTION"
