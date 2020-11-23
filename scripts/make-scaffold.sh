#!/bin/bash

for i in {01,02}
do
    mkdir -p "./day-$i/cmd"
    cat > "./day-$i/cmd/.keep" << KEEP
KEEP

    cat > "./day-$i/README.md" << README
# day-$i
## --- Part 1 ---
## --- Part 2 ---
README

    cat > "./day-$i/input" << INPUT
<insert input>
INPUT

    cat > "./day-$i/output" << OUTPUT
<insert output>
OUTPUT

    cat > "./day-$i/test.sh" << 'TEST'
#!/bin/bash
set -e
DIR=$(dirname $(realpath $0))

# Run tests
# Example: $DIR/../scripts/test-deno.sh $DIR ./cmd/main.deno.ts
TEST

    chmod +x ./day-$i/test.sh
done

