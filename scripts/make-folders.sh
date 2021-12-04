#!/usr/bin/env bash

# Make folders for all the days in the calendar
for DAY in {day-01,day-02,day-03,day-04,day-05,day-06,day-07,day-08,day-09,day-10,day-11,day-12,day-13,day-14,day-15,day-16,day-17,day-18,day-19,day-20,day-21,day-22,day-23,day-24,day-25}
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

echo "--- $DAY: --- ????? --- ❌"
#\$D/../../lang/go.sh     "\$D/solutions/*.go"  "\$D/io/*"
#\$D/../../lang/sml.sh    "\$D/solutions/*.sml" "\$D/io/*"
#\$D/../../lang/python.sh "\$D/solutions/*.py"  "\$D/io/*"
#\$D/../../lang/deno.sh   "\$D/solutions/*.ts"  "\$D/io/*"

exit 1337;

TEST
    chmod +x ./$DAY/test.sh
done

