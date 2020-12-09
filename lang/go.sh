#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/go.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/go.sh  "solutions/*.go"   "io/*"
# Expands to: ../../lang/go.sh   solutions/main.go  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1  # Expand string to list
IO_FILES=$2        # Expand string to list

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  go build -o $OUT $SOLUTION;

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "go" "$TIME" "$SOLUTION"
done

rm $OUT;
