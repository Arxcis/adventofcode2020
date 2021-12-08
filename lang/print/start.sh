#!/usr/bin/env bash
set -euo pipefail

CMD="$1"
FILE="$2"

# %-23s is to accomodate for the longest known solution name: "one-liner.stektpotet.bash"
printf "cat \$INPUT | %-8s %-23s" "$CMD" "$(basename -- $FILE)"

