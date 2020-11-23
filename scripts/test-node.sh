#!/bin/bash
set -e

# Usage:   ../test-node.sh FILENAME     DIR
# Example: ../test-node.sh main.node.ts /home/jonas/adventofcode2020/day-00-example

FILENAME=$1
DIR=$2

echo "$(cat $DIR/input)" | node "$DIR/cmd/$FILENAME" | diff - "$DIR/output"
echo "$DIR / node $FILENAME ✅"
