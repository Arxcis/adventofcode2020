#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/go.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/go.sh  "solutions/*.go"   "io/*"
# Expands to: ../../lang/go.sh   solutions/main.go  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  go build -o $OUT $SOLUTION;

  $D/print/start.sh "go" "$SOLUTION"
  START=$($D/time/start.sh)

  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)
  $D/print/stop.sh "$TIME"
done

rm $OUT;

