#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))


../../languages/deno.sh "$D/solutions/*.ts" "$D/io/*"

