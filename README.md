# adventofcode2020 🕯️ 🎄 ⛄

Welcome to this community project, where we collaboratively solve the 2020 edition of https://adventofcode.com/.

## Solutions per language per day

| Language | Total | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 |11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|
|----------|-------|----|----|----|----|----|----|----|----|----|----|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
| python   |    12 |  2 |  1 |  3 |  4 |  2 |    |    |    |    |    ||||||||||||||||
| golang   |     6 |  2 |  2 |  2 |  1 |  1 |    |    |    |    |    ||||||||||||||||
| c        |     5 |  1 |  1 |  1 |  1 |  1 |    |    |    |    |    ||||||||||||||||
| sml      |     5 |  1 |  1 |  1 |  1 |  1 |    |    |    |    |    ||||||||||||||||
| c++      |     2 |  1 |  1 |    |    |    |    |    |    |    |    ||||||||||||||||
| ruby     |     2 |  1 |    |    |  1 |    |    |    |    |    |    ||||||||||||||||
| rust     |     1 |  1 |    |    |    |    |    |    |    |    |    ||||||||||||||||
| zig      |     1 |  1 |    |    |    |    |    |    |    |    |    ||||||||||||||||
| bash     |     0 |    |    |    |    |    |    |    |    |    |    ||||||||||||||||
| java     |     0 |    |    |    |    |    |    |    |    |    |    ||||||||||||||||
| node     |     0 |  1 |    |    |    |    |    |    |    |    |    ||||||||||||||||
| php      |     0 |    |    |    |    |    |    |    |    |    |    ||||||||||||||||
| Total    |    36 | 11 |  6 |  7 |  7 |  5 |    |    |    |    |    ||||||||||||||||

*List of programming languages supported by our [Dockerfile](./Dockerfile)*

## Github CI status

![day-01](https://github.com/Arxcis/adventofcode2020/workflows/day-01/badge.svg)
![day-02](https://github.com/Arxcis/adventofcode2020/workflows/day-02/badge.svg)
![day-03](https://github.com/Arxcis/adventofcode2020/workflows/day-03/badge.svg)
![day-04](https://github.com/Arxcis/adventofcode2020/workflows/day-04/badge.svg)
![day-05](https://github.com/Arxcis/adventofcode2020/workflows/day-05/badge.svg)
![day-06](https://github.com/Arxcis/adventofcode2020/workflows/day-06/badge.svg)
![day-07](https://github.com/Arxcis/adventofcode2020/workflows/day-07/badge.svg)
![day-08](https://github.com/Arxcis/adventofcode2020/workflows/day-08/badge.svg)
![day-09](https://github.com/Arxcis/adventofcode2020/workflows/day-09/badge.svg)
![day-10](https://github.com/Arxcis/adventofcode2020/workflows/day-10/badge.svg)
![day-11](https://github.com/Arxcis/adventofcode2020/workflows/day-11/badge.svg)
![day-12](https://github.com/Arxcis/adventofcode2020/workflows/day-12/badge.svg)
![day-13](https://github.com/Arxcis/adventofcode2020/workflows/day-13/badge.svg)
![day-14](https://github.com/Arxcis/adventofcode2020/workflows/day-14/badge.svg)
![day-15](https://github.com/Arxcis/adventofcode2020/workflows/day-15/badge.svg)
![day-16](https://github.com/Arxcis/adventofcode2020/workflows/day-16/badge.svg)
![day-17](https://github.com/Arxcis/adventofcode2020/workflows/day-17/badge.svg)
![day-18](https://github.com/Arxcis/adventofcode2020/workflows/day-18/badge.svg)
![day-19](https://github.com/Arxcis/adventofcode2020/workflows/day-19/badge.svg)
![day-20](https://github.com/Arxcis/adventofcode2020/workflows/day-20/badge.svg)
![day-21](https://github.com/Arxcis/adventofcode2020/workflows/day-21/badge.svg)
![day-22](https://github.com/Arxcis/adventofcode2020/workflows/day-22/badge.svg)
![day-23](https://github.com/Arxcis/adventofcode2020/workflows/day-23/badge.svg)
![day-24](https://github.com/Arxcis/adventofcode2020/workflows/day-24/badge.svg)
![day-25](https://github.com/Arxcis/adventofcode2020/workflows/day-25/badge.svg)
![day-00-example](https://github.com/Arxcis/adventofcode2020/workflows/day-00-example/badge.svg)

*Github CI runs one `days/<day>/test.sh` for each day. Example: [days/day-00-example/test.sh](./days/day-01/test.sh)*

## [CONTRIBUTING.md](./CONTRIBUTING.md)

Fork today! Anyone is encouraged to contribute, and as a contributor you may do whatever you want with this code. Treat it as your own :+1:

**Contributors**

A shout-out to the developers over at Maritime Optima - https://github.com/orgs/MaritimeOptima/people - volunteering to support this project :pray:

Also a big thanks to the rest of our contributors :tada:
- [@Celebrian](https://github.com/Celebrian)
- [@Avokadoen](https://github.com/Avokadoen)
- [@Stektpotet](https://github.com/Stektpotet)

**Leaderboard**

Contributors are welcomed to join our private leaderboard :sunglasses: Use the join code **376961-8a514359** at https://adventofcode.com/2020/leaderboard/private

**Sharing**

If you enjoy working on this project, consider sharing it with your friends. The more the merrier :santa:


**To see all the language-versions run:**
```
make docker.versions      // For the docker container's versions
make versions             // For the host system's versions
```

## Getting started

### Test a single solution

```
$ cd days/day01
$ ../../languages/rust.sh input.txt output.txt solutions/day01.rs
cat INPUT | rustc day-01/solutions/day01.rs ✅
```

### Test one or more days
```
// Run tests inside docker container
make docker.example         // Expect example tests to succeed
make docker.day01           // Expect to succeed, testing only day-01 solutions
make docker.all             // Expect some days to succeed, some to fail

// Run tests on host
make test.example           // Expect example tests to succeed
make test.day01             // Expect to succeed, testing only day-01 solutions
make test.all               // Expect some days to succeed, some to fail
```

## Demo

[![asciicast](https://asciinema.org/a/qVa7n8LmDnynRuBRvZzY5Kr7N.svg)](https://asciinema.org/a/qVa7n8LmDnynRuBRvZzY5Kr7N)
