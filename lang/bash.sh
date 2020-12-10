#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

# Usage:      ../../lang/bash.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/bash.sh  "solutions/*.bash"   "io/*"
# Expands to: ../../lang/bash.sh   solutions/main.bash  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

for SOLUTION in $SOLUTION_FILES
do
  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | bash $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "bash" "$TIME" "$SOLUTION"
done
