#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/rust.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/rust.sh  "solutions/*.rs"   "io/*"
# Expands to: ../../lang/rust.sh   solutions/main.rs  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  rustc $SOLUTION -o $OUT;

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "rustc" "$TIME" "$SOLUTION"

done

rm $OUT;
