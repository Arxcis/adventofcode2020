#!/usr/bin/env bash

# Make folders for all the days in the calendar
for i in {01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
do
    DAY="days/day-$i"
    rm -r "./$DAY"
    mkdir -p "./$DAY/solutions/"
    cat > "./$DAY/solutions/.keep" << KEEP
KEEP

    cat > "./$DAY/README.md" << README
# $DAY
## --- Part 1 ---
## --- Part 2 ---
README

    cat > "./$DAY/input.txt" << INPUT
<insert input>
INPUT

    cat > "./$DAY/output.txt" << OUTPUT
<insert output>
OUTPUT

    cat > "./$DAY/test.sh" << 'TEST'
#!/usr/bin/env bash
set -e

DIR=$(dirname $(realpath $0))

# Run tests
# Example: $DIR/../../scripts/test-rust.sh $DIR ./solutions/main.rs

echo "$DIR / --- Empty --- ❌";
exit 1337;
TEST
    chmod +x ./$DAY/test.sh
done

