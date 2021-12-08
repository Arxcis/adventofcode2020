#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

# Usage:      ../../lang/deno.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../lang/deno.sh  "solutions/*.ts"   "io/*"
# Expands to: ../../lang/deno.sh   solutions/main.ts  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1
IO_FILES=$2
for SOLUTION in $SOLUTION_FILES
do
  deno install -f --quiet "$SOLUTION" >/dev/null

  $D/print/start.sh "deno" "$SOLUTION"
  START=$($D/time/start.sh)

  while read INPUT OUTPUT; do
    cat $INPUT | deno run --allow-read $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  TIME=$($D/time/stop.sh $START)
  $D/print/stop.sh "$TIME"
done

