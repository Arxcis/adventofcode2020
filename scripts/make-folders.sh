#!/usr/bin/env bash

# Make folders for all the days in the calendar
for i in {10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
do
    DISPLAY_DAY="Day $i"
    DAY="days/day-$i"
    rm -r "./$DAY"
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

echo "--- $DISPLAY_DAY: --- ????? --- ❌"
#\$D/../../languages/go.sh     "\$D/solutions/*.go"  "\$D/io/*"
#\$D/../../languages/sml.sh    "\$D/solutions/*.sml" "\$D/io/*"
#\$D/../../languages/python.sh "\$D/solutions/*.py"  "\$D/io/*"
#\$D/../../languages/deno.sh   "\$D/solutions/*.ts"  "\$D/io/*"

exit 1337;
TEST
    chmod +x ./$DAY/test.sh
done

