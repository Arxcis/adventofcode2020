#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

# Usage:      ../../lang/php.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/php.sh  "solutions/*.php"   "io/*"
# Expands to: ../../lang/php.sh   solutions/main.php  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

for SOLUTION in $SOLUTION_FILES
do
  $D/print/start.sh "php" "$SOLUTION"
  START=$($D/time/start.sh)

  while read INPUT OUTPUT; do
    cat $INPUT | php $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)
  $D/print/stop.sh "$TIME"
done

