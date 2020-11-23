#!/bin/bash
set -e

# Usage:   ../test-deno.sh FILENAME     DIR
# Example: ../test-deno.sh main.deno.ts /home/jonas/adventofcode2020/day-00-example

FILENAME=$1
DIR=$2

echo "$(cat $DIR/input)" | deno run "$DIR/cmd/$FILENAME" | diff - "$DIR/output"
echo "$DIR / deno run $FILENAME ✅"
