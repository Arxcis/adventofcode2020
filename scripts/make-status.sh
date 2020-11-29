for i in {01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
do
  DAY="days/day-${i}"
  cat >> "./README.md" << STATUS
![$DAY](https://github.com/Arxcis/adventofcode2020/workflows/$DAY/badge.svg)
STATUS
done
