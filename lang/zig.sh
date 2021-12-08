#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

#
# Usage:      ../../lang/zig.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/zig.sh  "solutions/*.zig"   "io/*"
# Expands to: ../../lang/zig.sh   solutions/main.zig  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2

OUT="$(mktemp)"

for SOLUTION in $SOLUTION_FILES
do
  SOLUTION_NAME="zig_solution"
  TEMP_SOURCE="/tmp/$SOLUTION_NAME.zig"
  TEMP_BIN="/tmp/$SOLUTION_NAME"

  # Output directory can be controlled with zig build scripts, but seemingly has no compiler flag for it
  # Should probably refactor this later as it is somewhat cumbersome ...
  cp $SOLUTION $TEMP_SOURCE
  cd "/tmp/"
  zig build-exe $TEMP_SOURCE --name $SOLUTION_NAME
  cd - >/dev/null

  $D/print/start.sh "zig" "$SOLUTION"
  START=$($D/time/start.sh)

  # Pair-wise iteration
  while read INPUT OUTPUT; do
    cat $INPUT | $TEMP_BIN | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)
  $D/print/stop.sh "$TIME"
done

