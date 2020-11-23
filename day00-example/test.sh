#!/bin/bash

set -e

SCRIPT_PATH=`realpath $0`

TASK_DIR=`dirname $SCRIPT_PATH`
ANSWERS_DIR="$TASK_DIR/answers"
INPUT=$(cat $TASK_DIR/input)
OUTPUT="$TASK_DIR/output"
SUCCESS="✅"

TASK_NAME="${TASK_DIR%"${TASK_DIR##*[!/]}"}"
TASK_NAME="${TASK_NAME##*/}"

#
# Run tests for day00
#
echo "$INPUT" | deno run "$ANSWERS_DIR/main.deno.ts" | diff - $OUTPUT
echo "$TASK_NAME: deno $SUCCESS"

echo "$INPUT" | go run "$ANSWERS_DIR/main.go" | diff - $OUTPUT
echo "$TASK_NAME: go $SUCCESS"

echo "$INPUT" | node "$ANSWERS_DIR/main.node.mjs" | diff - $OUTPUT
echo "$TASK_NAME: node $SUCCESS"

echo "$INPUT" | python3 "$ANSWERS_DIR/main.py" | diff - $OUTPUT
echo "$TASK_NAME: python $SUCCESS"
