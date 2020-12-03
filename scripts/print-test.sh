#!/usr/bin/env bash
set -e

CMD="$1"
TIME="$2ms"
FILE="$3"

printf "cat INPUT | %-8s %-16s %-7s    ✅\n" "$CMD" "$(basename -- $FILE)" "$TIME"
