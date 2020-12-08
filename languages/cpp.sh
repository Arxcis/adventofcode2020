#!/usr/bin/env bash
set -euo pipefail

#
# Usage:      ../../languages/cpp.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/cpp.sh  "solutions/*.cpp"   "io/*"
# Expands to: ../../languages/cpp.sh   solutions/main.cpp  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1  # Expand FILES
IO_FILES=$2        # Expand FILES

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  g++ $SOLUTION -o $OUT;

  start=$(($(date +%s%N)/1000000))

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "g++" "$TIME" "$SOLUTION"

done
rm $OUT;
