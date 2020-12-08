#!/usr/bin/env bash
set -euo pipefail

# Usage:      ../../languages/bash.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/bash.sh  "solutions/*.bash"   "io/*"
# Expands to: ../../languages/bash.sh   solutions/main.bash  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1   # Expand FILES
IO_FILES=$2         # Expand FILES

for SOLUTION in $SOLUTION_FILES
do
  start=$(($(date +%s%N)/1000000))

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | bash $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"


  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "bash" "$TIME" "$SOLUTION"
done
