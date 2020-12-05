#!/usr/bin/env bash
set -euo pipefail

CMD="$1"
TIME="$2ms"
FILE="$3"

# %-22s is to accomodate for the longest known solution name: "day04.stektpotet.bash"
printf "cat INPUT | %-8s %-22s %-7s    ✅\n" "$CMD" "$(basename -- $FILE)" "$TIME"
