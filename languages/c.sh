#!/usr/bin/env bash
set -euo pipefail

#
# Usage:      ../../languages/c.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/c.sh  "solutions/*.c"   "io/*"
# Expands to: ../../languages/c.sh   solutions/main.c  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1  # Expand string to list
IO_FILES=$2        # Expand string to list

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  gcc $SOLUTION -o $OUT;

  start=$(($(date +%s%N)/1000000))

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "gcc" "$TIME" "$SOLUTION"
done

rm $OUT;
