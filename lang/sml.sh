#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/sml.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/sml.sh  "solutions/*.sml"   "io/*"
# Expands to: ../../lang/sml.sh   solutions/main.sml  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"
trap 'rm -f "$OUT"' EXIT

for SOLUTION in $SOLUTION_FILES
do
  $D/print/start.sh "polyc" "$SOLUTION"

  cd $(dirname $(realpath $SOLUTION))

  polyc "$SOLUTION" -o "$OUT"

  cd - >/dev/null

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/stop.sh "$TIME"
done

