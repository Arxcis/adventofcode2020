#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/kotlin.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/kotlin.sh  "solutions/*.kt"    "io/*"
# Expands to: ../../lang/kotlin.sh  "solutions/main.kt" "io/alice.input io/alice.output io/bob.input io/bob.output"
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  kotlinc-native $SOLUTION -o $OUT;
  chmod +x $OUT.kexe;

  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $OUT.kexe | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)

  $D/print/success.sh "kotlinc" "$TIME" "$SOLUTION"
done

rm $OUT*;

