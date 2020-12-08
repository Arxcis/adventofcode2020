#!/usr/bin/env bash
set -euo pipefail

# Usage:      ../../languages/node.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/node.sh  "solutions/*.mjs"   "io/*"
# Expands to: ../../languages/node.sh   solutions/main.mjs  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1   # Expand FILES
IO_FILES=$2         # Expand FILES

for SOLUTION in $SOLUTION_FILES
do
  start=$(($(date +%s%N)/1000000))

  while read INPUT OUTPUT; do
    cat $INPUT | ruby $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "ruby" "$TIME" "$SOLUTION"
done
