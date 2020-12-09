#!/usr/bin/env bash
set -euo pipefail

#
# Usage:      ../../languages/sml.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/sml.sh  "solutions/*.sml"   "io/*"
# Expands to: ../../languages/sml.sh   solutions/main.sml  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1  # Expand string to list
IO_FILES=$2        # Expand string to list

OUT="$(mktemp)"
trap 'rm -f "$OUT"' EXIT

for SOLUTION in $SOLUTION_FILES
do

  cd $(dirname $(realpath $SOLUTION))

  polyc "$SOLUTION" -o "$OUT"

  cd - >/dev/null

  start=$(($(date +%s%N)/1000000))

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "polyc" "$TIME" "$SOLUTION"
done
