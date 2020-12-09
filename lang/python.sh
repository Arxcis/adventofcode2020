#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

# Usage:      ../../lang/python.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/python.sh  "solutions/*.py"   "io/*"
# Expands to: ../../lang/python.sh   solutions/main.py  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

for SOLUTION in $SOLUTION_FILES
do
  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "python3" "$TIME" "$SOLUTION"
done
