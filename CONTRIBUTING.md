# Contributing

## How do I add a solution for a given day?

1. Pop some popcorn :popcorn: (or whatever you enjoy :lollipop: :champagne: :milk_glass: :wine_glass: :tropical_drink: :chocolate_bar: :beer:)
2. Fork
3. Write a solution, in the language of your choice. Example: `vim day-03/solutions/super-optimized.py`
4. Test your solution.

```sh
../languages/python.sh day-03/input.txt day-03/output.txt day-03/solutions/super-optimized.py
```

5. Make a Pull Request to the `main` branch.
6. Merge when the tests pass!
7. Remember to have fun :tada:


## How do I add a language?

1. Add the language you want to the `Dockerfile`
2. Add a language test-script in `languages/<new-language>.sh`
3. Add an example solution in `days/day-00-example/solutions/example.<new-language>`
4. Make a PR to `main`-branch.
5. @Arxcis will do `make docker.build` and `make docker.push` and merge your PR on his machine ASAP :racing_car:

## How are solutions tested?

Every solution gets the `input.txt`-file delivered to `stdin` using `cat`, and whatever is written to `stdout` is compared for equality against `output.txt` using `diff`. This is identical for every language.

```sh
#!/usr/bin/env bash
cat input.txt | <solution-in-any-language> | diff - output.txt
```
See [day-00-example/solutions/](https://github.com/Arxcis/adventofcode2020/tree/main/days/day-00-example/solutions), for examples on how to read from `stdin` and how to write to `stdout` in different languages.
