# adventofcode2020 🕯️ 🎄 ⛄

Welcome to this community project, where we collaboratively solve the 2020 edition of https://adventofcode.com/.


## Test status

![2021](https://github.com/Arxcis/adventofcode2020/workflows/2021/badge.svg)
![2020](https://github.com/Arxcis/adventofcode2020/workflows/2020/badge.svg)

*Github CI runs the `days/<day>/test.sh` for each day. Example: [days/day-01/test.sh](./days/day-01/test.sh)*

![day-example](https://github.com/Arxcis/adventofcode2020/workflows/day-example/badge.svg)




## Solutions per language per day

| Language  | Total  | 01   |  02 |  03 |  04  |  05  | 06   | 07  | 08  | 09  | 10  | 11  | 12  | 13  | 14  | 15  | 16  | 17  | 18  | 19  | 20  | 21  | 22  | 23  | 24  | 25  |
|-----------|--------|------|-----|-----|------|------|------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| python3   | **52** |  2   |  1  |  3  |  4   |  4   |  3   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 2   | 1   | 1   | 2   | 2   | 2   | 2   | 1   |
| sml       | **19** |  1   |  1  |  1  |  1   |  1   |  1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   | 1   |     |     |     |     |     |     |
| deno.ts   | **15** |  1   |  1  |  1  |  1   |  1   |  1   | 1   | 1   | 1   | 1   | 1   | 1   |     | 1   | 1   | 1   |     |     |     |     |     |     |     |     |     |
| golang    | **13** |  2   |  2  |  2  |  1   |  2   |  2   | 1   | 1   |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| zig       |  **9** |  1   |  1  |  1  |  1   |  1   |  1   | 1   | 1   | 1   |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| c         |  **6** |  1   |  1  |  1  |  1   |  1   |  1   |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| node.js   |  **4** |  1   |     |     |  1   |      |  1   | 1   |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| c++       |  **2** |  1   |  1  |     |      |      |      |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| ruby      |  **2** |  1   |     |     |  1   |      |      |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| rust      |  **1** |  1   |     |     |      |      |      |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| bash      |  **0** |      |     |     |      |      |      |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| php       |  **0** |      |     |     |      |      |      |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
| **Total** | **123**|**12**|**8**|**9**|**11**|**10**|**10**|**7**|**6**|**5**|**4**|**4**|**4**|**3**|**4**|**4**|**4**|**3**|**3**|**2**|**1**|**2**|**2**|**2**|**2**|**1**|


*Last updated: 2021-01-06 13:52:00Z*

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
$ ./lang/rust.sh "2020/day-01/solutions/day01.rs" "2020/day-01/io/*"
cat INPUT | rustc    day01.rs                662ms      ✅
```

### Test inside docker container
```sh
make example
make
make all
make 2020
make 2020.day01
```

