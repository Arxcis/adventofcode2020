#!/usr/bin/env bash
set -euo pipefail

# Usage:    ../../languages/python.sh  SOLUTION           INPUT/OUTPUT-pairs
#
# Example:  ../../languages/python.sh  solutions/main.py  io/*
# Expanded: ../../languages/python.sh  solutions/main.py  io/alice.input io/alice.output io/bob.input io/bob.output
#
SOLUTION="$1"

start=$(($(date +%s%N)/1000000))

shift

# Pair-wise iteration
while read INPUT OUTPUT; do
  cat $INPUT | python3 $SOLUTION | diff - $OUTPUT
done < <(echo $@ | xargs -n2)

end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "python3" "$TIME" "$SOLUTION"
