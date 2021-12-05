#!/usr/bin/env bash

# Make folders for all the days in the calendar
for DAY in {day01,day02,day03,day04,day05,day06,day07,day08,day09,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25}
do
    DAY="$YEAR/$DAY"

    rm -r "./$DAY" > /dev/null
    mkdir -p "./$DAY/solutions/"
    touch "./$DAY/solutions/.keep"

    mkdir -p "./$DAY/io/"
    touch "./$DAY/io/.keep"

    cat > "./$DAY/README.md" << README
# $DAY
## --- Part 1 ---
## --- Part 2 ---

README

    cat > "./$DAY/test.sh" << TEST
#!/usr/bin/env bash
set -euo pipefail

D=\$(dirname \$(realpath \$0))

echo "$YEAR / --- $DAY: --- ????? --- ❌"
#\$D/../../lang/go.sh     "\$D/solutions/*.go"  "\$D/io/*"
#\$D/../../lang/sml.sh    "\$D/solutions/*.sml" "\$D/io/*"
#\$D/../../lang/python.sh "\$D/solutions/*.py"  "\$D/io/*"
#\$D/../../lang/deno.sh   "\$D/solutions/*.ts"  "\$D/io/*"

exit 1337;

TEST
    chmod +x ./$DAY/test.sh
done

