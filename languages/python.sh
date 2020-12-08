#!/usr/bin/env bash
set -euo pipefail

# Usage:    ../../languages/python.sh  "SOLUTIONS"        "INPUT/OUTPUT-pairs"
#
# Example:  ../../languages/python.sh "solutions/*.py"   "io/*"
# Expanded: ../../languages/python.sh  solutions/main.py  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTIONS=${1} # deliberitely expand arg
IO=${2}        # deliberitely expand arg


for SOLUTION in $SOLUTIONS ; do
  start=$(($(date +%s%N)/1000000))

  # Pairwise iteration
  while read INPUT OUTPUT; do
	  cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
  done < <(echo $IO | xargs -n2)

  end=$(($(date +%s%N)/1000000))
  TIME="$(expr $end - $start)"
  D=$(dirname $(realpath $0))
  $D/../scripts/print-test.sh "python3" "$TIME" "$SOLUTION"
done
