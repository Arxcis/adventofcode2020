#!/usr/bin/env bash
set -euo pipefail

# Usage:   ./languages/java.sh INPUT                 OUTPUT                 SOLUTION_DIR          JAVA_CLASSNAME
# Example: ./languages/java.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions Example

INPUT="$1"
OUTPUT="$2"
SOLUTION_DIR="$3"
JAVA_CLASSNAME="$4"

JAVA_CLASSFILE="$JAVA_CLASSNAME.class"

cd $SOLUTION_DIR
javac "$JAVA_CLASSNAME.java"

start=$(($(date +%s%N)/1000000))
cat $INPUT | java $JAVA_CLASSNAME | diff - $OUTPUT
end=$(($(date +%s%N)/1000000))

TIME="$(expr $end - $start)"

D=$(dirname $(realpath $0))
$D/../scripts/print-test.sh "javac" "$TIME" "$SOLUTION_DIR/$JAVA_CLASSNAME.java"

rm "$DIR/$SOLUTION_DIR/$JAVA_CLASSFILE";
