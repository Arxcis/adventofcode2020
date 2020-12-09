#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/c.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/c.sh  "solutions/*.c"   "io/*"
# Expands to: ../../lang/c.sh   solutions/main.c  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  gcc $SOLUTION -o $OUT;

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "gcc" "$TIME" "$SOLUTION"
done

rm $OUT;
