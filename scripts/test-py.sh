#!/bin/bash
set -e

# Usage:   ../test-py.sh FILENAME  DIR
# Example: ../test-py.sh main.py   /home/jonas/adventofcode2020/day-00-example

FILENAME=$1
DIR=$2

echo "$(cat $DIR/input)" | python3 "$DIR/cmd/$FILENAME" | diff - "$DIR/output"
echo "$DIR / python3 $FILENAME ✅"
