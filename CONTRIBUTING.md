# Contributing

## How do I add a solution for a given day?

1. Pop a can of beer :beer: (or whatever is your favourite :popcorn: :lollipop: :champagne: :milk_glass: :wine_glass: :tropical_drink: :chocolate_bar:
2. Make a branch. Example: `git checkout -b jonas/day-03`
3. Write a solution, in the language of your choice. Example: `vim day-03/solutions/super-optimized.py`
4. Test your solution.

```sh
./languages/py.sh days/day-03/input.txt days/day-03/output.txt days/day-03/solutions/super-optimized.py
```

5. Make a Pull Request to the `main` branch.
6. Merge when the tests pass!
7. Remember to have fun :tada:


## How do I add a language?

1. Add the language you want to the `Dockerfile`
2. Add a language test-script in `languages/<new-language>.sh`
3. Add an example solution in `days/day-00-example/solutions/example.<new-language>`
4. Make a PR to `main`-branch.
5. @Arxcis will do `make docker.build` and `make docker.push` and merge your PR on his machine ASAP.

## How are solutions tested?

Every solution gets the `input.txt`-file delivered to `stdin` using `cat`, and whatever is written to `stdout` is compared for equality against `output.txt` using `diff`. This is identical for every language.

```sh
#!/usr/bin/env bash
cat input.txt | <solution-in-any-language> | diff - output.txt
```
See [day-00-example/solutions/](https://github.com/Arxcis/adventofcode2020/tree/main/days/day-00-example/solutions), for examples on how to read from `stdin` and how to write to `stdout` in different languages.

## Languages supported by CI - so far

```
bash    main.bash
gcc     main.c -o gcc.out && ./gcc.out
g++     main.cpp -o g++.out && ./g++.out
go run  main.go
javac   Main.java && java Main
node    main.node.mjs
php     main.php
python3 main.py
rustc   main.rs -o rustc.out && ./rustc.out
polyc   main.sml -o sml.out && ./sml.out
```
