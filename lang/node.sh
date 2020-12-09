#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

# Usage:      ../../lang/node.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/node.sh  "solutions/*.mjs"   "io/*"
# Expands to: ../../lang/node.sh   solutions/main.mjs  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1   # Expand string to list
IO_FILES=$2         # Expand string to list

for SOLUTION in $SOLUTION_FILES
do
  START=$($D/time/start.sh)

  while read INPUT OUTPUT; do
    cat $INPUT | node --harmony-top-level-await $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "node" "$TIME" "$SOLUTION"
done
