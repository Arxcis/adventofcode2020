# adventofcode(2020|2021) 🕯️ 🎄 ⛄

Welcome to this community project, where we collaboratively solve https://adventofcode.com/.


## CI test status

![examples](https://github.com/Arxcis/adventofcode2020/workflows/examples/badge.svg)
![2021](https://github.com/Arxcis/adventofcode2020/workflows/2021/badge.svg)
![2020](https://github.com/Arxcis/adventofcode2020/workflows/2020/badge.svg)

*Github CI runs the `<year>/<day>/test.sh` for each day. Example: [2020/day01/test.sh](./2020/day01/test.sh)*


## Solved days by language

| Language  |**Total**| 2020 | 2021 |
|-----------|--------|------|------|
| python3   | **28** |  25  |   3  |
| sml       | **19** |  19  |      |
| deno.ts   | **15** |  15  |      |
| rust      | **14** |  1   |  13  |
| zig       | **11** |  9   |   2  |
| golang    | **8**  |  8   |      |
| c         | **6**  |  6   |      |
| node.js   | **4**  |  4   |      |
| c++       | **2**  |  2   |      |
| ruby      | **2**  |  2   |      |

*Last updated: 2021-12-18*

See all languages we support in our [Dockerfile](./Dockerfile).

Run `make versions` to see installed language versions in the docker-container.


## [CONTRIBUTING.md](./CONTRIBUTING.md)

Fork today! Anyone is encouraged to contribute, and as a contributor you may do whatever you want with this code. Treat it as your own :+1:

**Contributors**

A special thanks to the developers over at **Maritime Optima** :ship: - https://github.com/orgs/MaritimeOptima/people - volunteering to support this project :pray:
- [@Arxcis](https://github.com/Arxcis), [@jorgenhanssen](https://github.com/jorgenhanssen), [@preng69](https://github.com/preng69), [@hypirion](https://github.com/hypirion), [@tholok97](https://github.com/tholok97), [@klyve](https://github.com/klyve),

Also a big thanks to the rest of our contributors :tada:
- [@Celebrian](https://github.com/Celebrian)
- [@Avokadoen](https://github.com/Avokadoen)
- [@Stektpotet](https://github.com/Stektpotet)

**Leaderboard**

Contributors are welcomed to join our private leaderboard :sunglasses: Use the join code **376961-8a514359** at https://adventofcode.com/2020/leaderboard/private

**Sharing**

If you enjoy working on this project, consider sharing it with your friends. The more the merrier :santa:

## Getting started

### Test solutions on your system
```sh
$ ./lang/rust.sh "2020/day01/solutions/day01.rs" "2020/day01/io/*"
cat INPUT | rustc    day01.rs                662ms      ✅
```

### Test inside docker container
```sh
# Test everything:
make

# Test year:
make name=2021

# Test day:
make name=2021/day01
```
