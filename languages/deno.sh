#!/usr/bin/env bash
set -euo pipefail

# Usage:      ../../languages/deno.sh  "SOLUTION_FILES"   "IO_FILES"
#
# Example:    ../../languages/deno.sh  "solutions/*.ts"   "io/*"
# Expands to: ../../languages/deno.sh   solutions/main.ts  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION_FILES=$1   # Expand string to list
IO_FILES=$2         # Expand string to list

for SOLUTION in $SOLUTION_FILES
do
  deno install -f --quiet "$SOLUTION" >/dev/null

  start=$(($(date +%s%N)/1000000))

  while read INPUT OUTPUT; do
    cat $INPUT | deno run --allow-read $SOLUTION | diff - $OUTPUT
  done < <(echo $IO_FILES | xargs -n2)

  end=$(($(date +%s%N)/1000000))

  TIME="$(expr $end - $start)"

  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "deno" "$TIME" "$SOLUTION"
done
