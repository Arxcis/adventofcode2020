#!/usr/bin/env bash
set -e

# Usage:   ./languages/java.sh INPUT                 OUTPUT                 SOLUTION_DIR          JAVA_CLASSNAME
# Example: ./languages/java.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions Example

INPUT="$1"
OUTPUT="$2"
SOLUTION_DIR="$3"
JAVA_CLASSNAME="$4"

JAVA_CLASSFILE="$JAVA_CLASSNAME.class"

cd $SOLUTION_DIR
javac "$JAVA_CLASSNAME.java"
cat $INPUT | java $JAVA_CLASSNAME | diff - $OUTPUT
rm "$DIR/$SOLUTION_DIR/$JAVA_CLASSFILE";
echo "cat INPUT | javac $SOLUTION_DIR/$JAVA_CLASSNAME.java ✅"
