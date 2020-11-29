INPUT=$(cat -)

sum_all=0;
while read num; do ((sum_all += num)); done < <(echo "$INPUT")

sum_odd=0;
while read num; do ((sum_odd += num)); done < <(echo "$INPUT" | grep "^[0-9]*[13579]$")

echo "$sum_all"
echo "$sum_odd"
