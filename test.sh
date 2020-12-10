#!/usr/bin/env bash
set -euo pipefail
D=$(dirname $(realpath $0))

for day in $(ls days); do $D/days/$day/test.sh; done
