#!/usr/bin/env bash
set -euo pipefail

# Usage:   ./languages/sml.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/sml.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.sml

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
OUT="$(mktemp)"
trap 'rm -f "$OUT"' EXIT

polyc "$SOLUTION" -o "$OUT"
"$OUT" < "$INPUT" | diff - "$OUTPUT"

echo "polyc $SOLUTION -o out.sml && ./out.sml ✅"
