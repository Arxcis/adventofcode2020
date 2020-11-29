INPUT=$(cat -)

# sum_all
echo "$INPUT" | paste -sd+ | bc

# sum_odd
echo "$INPUT" | grep "^[0-9]*[13579]$" | paste -sd+ | bc
