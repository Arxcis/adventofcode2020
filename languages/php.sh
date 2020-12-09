#!/usr/bin/env bash
set -euo pipefail

# Usage:      ../../languages/php.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/php.sh  "solutions/*.php"   "io/*"
# Expands to: ../../languages/php.sh   solutions/main.php  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1   # Expand string to list
IO_FILES=$2         # Expand string to list

for SOLUTION in $SOLUTION_FILES
do
  start=$(($(date +%s%N)/1000000))

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | php $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "php" "$TIME" "$SOLUTION"
done
