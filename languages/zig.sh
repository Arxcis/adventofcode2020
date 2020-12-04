#!/usr/bin/env bash
set -e

# Usage:   ./languages/zig.sh INPUT                 OUTPUT                 SOLUTION
# Example: ./languages/zig.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/main.zig

INPUT="$1"
OUTPUT="$2"
SOLUTION="$3"
CURRENT_PATH="$(pwd)"
SOLUTION_NAME="zig_solution"
TEMP_SOURCE="/tmp/$SOLUTION_NAME.zig"
TEMP_BIN="/tmp/$SOLUTION_NAME"



# Output directory can be controlled with zig build scripts, but seemingly has no compiler flag for it
# Should probably refactor this later as it is somewhat cumbersome ... 
cp $SOLUTION $TEMP_SOURCE
cd "/tmp/"
zig build-exe $TEMP_SOURCE --name $SOLUTION_NAME
cd $CURRENT_PATH

start=$(($(date +%s%N)/1000000))
cat $INPUT | $TEMP_BIN | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "zig run" "$TIME" "$SOLUTION"
