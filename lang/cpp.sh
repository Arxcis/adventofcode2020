#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/cpp.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/cpp.sh  "solutions/*.cpp"   "io/*"
# Expands to: ../../lang/cpp.sh   solutions/main.cpp  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1  # Expand string to list
IO_FILES=$2        # Expand string to list

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  g++ $SOLUTION -o $OUT;

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "g++" "$TIME" "$SOLUTION"

done
rm $OUT;
