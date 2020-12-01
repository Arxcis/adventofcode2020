# adventofcode2020
Collaboratively solve the 2020 edition of https://adventofcode.com/, and test the solutions using Github CI.

## [CONTRIBUTING.md](./CONTRIBUTING.md)

## Status
Here you can see the status of automatic tests run by Github CI:

![day-01](https://github.com/Arxcis/adventofcode2020/workflows/days/day-01/badge.svg)
![day-02](https://github.com/Arxcis/adventofcode2020/workflows/days/day-02/badge.svg)
![day-03](https://github.com/Arxcis/adventofcode2020/workflows/days/day-03/badge.svg)
![day-04](https://github.com/Arxcis/adventofcode2020/workflows/days/day-04/badge.svg)
![day-05](https://github.com/Arxcis/adventofcode2020/workflows/days/day-05/badge.svg)
![day-06](https://github.com/Arxcis/adventofcode2020/workflows/days/day-06/badge.svg)
![day-07](https://github.com/Arxcis/adventofcode2020/workflows/days/day-07/badge.svg)
![day-08](https://github.com/Arxcis/adventofcode2020/workflows/days/day-08/badge.svg)
![day-09](https://github.com/Arxcis/adventofcode2020/workflows/days/day-09/badge.svg)
![day-10](https://github.com/Arxcis/adventofcode2020/workflows/days/day-10/badge.svg)
![day-11](https://github.com/Arxcis/adventofcode2020/workflows/days/day-11/badge.svg)
![day-12](https://github.com/Arxcis/adventofcode2020/workflows/days/day-12/badge.svg)
![day-13](https://github.com/Arxcis/adventofcode2020/workflows/days/day-13/badge.svg)
![day-14](https://github.com/Arxcis/adventofcode2020/workflows/days/day-14/badge.svg)
![day-15](https://github.com/Arxcis/adventofcode2020/workflows/days/day-15/badge.svg)
![day-16](https://github.com/Arxcis/adventofcode2020/workflows/days/day-16/badge.svg)
![day-17](https://github.com/Arxcis/adventofcode2020/workflows/days/day-17/badge.svg)
![day-18](https://github.com/Arxcis/adventofcode2020/workflows/days/day-18/badge.svg)
![day-19](https://github.com/Arxcis/adventofcode2020/workflows/days/day-19/badge.svg)
![day-20](https://github.com/Arxcis/adventofcode2020/workflows/days/day-20/badge.svg)
![day-21](https://github.com/Arxcis/adventofcode2020/workflows/days/day-21/badge.svg)
![day-22](https://github.com/Arxcis/adventofcode2020/workflows/days/day-22/badge.svg)
![day-23](https://github.com/Arxcis/adventofcode2020/workflows/days/day-23/badge.svg)
![day-24](https://github.com/Arxcis/adventofcode2020/workflows/days/day-24/badge.svg)
![day-25](https://github.com/Arxcis/adventofcode2020/workflows/days/day-25/badge.svg)
![day-00-example](https://github.com/Arxcis/adventofcode2020/workflows/days/day-00-example/badge.svg)

## Testing a single solution

```
$ ./scripts/test-rust.sh days/day-01/input.txt days/day-01/output.txt days/day-01/solutions/day01.rs 
cat INPUT | rustc days/day-01/solutions/day01.rs ✅
```

## Testing if you are running Docker

If you are running docker, you can run tests inside a docker-container by doing:
```
make docker.example         // Expect example tests to succeed
make docker.01              // Expect to succeed testing only day-01 solutions
make docker.all             // Expect some days to succeed, some to fail
```

## Testing if you are not running Docker
If you are not running docker, you have to install languages we support on your host system. See the [Dockerfile](./Dockerfile) for how you can do this on debian-based systems.

You can run the tests directly on your host system by doing:
```
make test.example           // Expect example tests to succeed
make test.01                // Expect to succeed testing only day-01 solutions
make test.all               // Expect days to succeed, some to fail
```


## Demo

[![asciicast](https://asciinema.org/a/82OAZ2P8MLxVvVT568rFEjh0n.svg)](https://asciinema.org/a/82OAZ2P8MLxVvVT568rFEjh0n)
