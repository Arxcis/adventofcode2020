#!/usr/bin/env bash
set -e

CMD="$1"
TIME="$2ms"
FILE="$3"

printf "cat input.txt | %-16s in %-8s✅ %s\n" "$(basename -- $FILE)" "$TIME" "$CMD"
