#!/usr/bin/env bash
set -euo pipefail

CMD="$1"
TIME="$2ms"
FILE="$3"

# %-23s is to accomodate for the longest known solution name: "one-liner.stektpotet.bash"
printf "cat INPUT | %-8s %-23s %-7s    ✅\n" "$CMD" "$(basename -- $FILE)" "$TIME"
