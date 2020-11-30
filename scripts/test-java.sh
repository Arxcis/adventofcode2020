#!/usr/bin/env bash
set -e

# Usage:   ../test-c.sh DIR     SOLUTION_DIR JAVA_CLASSNAME
# Example: ../test-c.sh /day-03 solutions    Main

DIR="$1"
SOLUTION_DIR="$2"
JAVA_CLASSNAME="$3"
JAVA_CLASSFILE="$JAVA_CLASSNAME.class"

cd "$DIR/$SOLUTION_DIR"
javac "$JAVA_CLASSNAME.java"
cat "$DIR/input.txt" | java "$JAVA_CLASSNAME" | diff - "$DIR/output.txt"
rm "$DIR/$SOLUTION_DIR/$JAVA_CLASSFILE";
echo "$DIR / javac $JAVA_CLASSNAME.java && java $JAVA_CLASSNAME ✅"
