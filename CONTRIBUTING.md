# Contributing

## How do I add a solution for a given day?

1. Pop some popcorn :popcorn: (or whatever you enjoy :lollipop: :champagne: :milk_glass: :wine_glass: :tropical_drink: :chocolate_bar: :beer:)
2. Fork
3. Write a solution, in the language of your choice. Example: `vim days/day-03/solutions/super-optimized.py`
4. Test your solution

```sh
$ ./lang/python.sh "days/day-03/solutions/super-optimized.py" "days/day-03/io/my.input days/day-03/io/my.output"

# ..or use the short-hand
$ ./lang/python.sh "days/day-03/**/*.py" "days/day-03/io/*"

cat INPUT | python3  day03.klyve.py          13ms       ✅
cat INPUT | python3  day03.preng.py          11ms       ✅
cat INPUT | python3  one-liner.py            12ms       ✅
```

5. Make sure `days/day03/test.sh` tests your solution.

6. To test the whole day do:
```sh
./days/day03/test.sh
# or
make test.day03
# or
make docker.day03
```

7. When you are happy with local testing, make a Pull Request to the `main` branch.
8. One of the maintainers will merge PR's, at the of each day.
9. Remember to have fun :tada:


## How do I add a language?

1. Add the language you want to the `Dockerfile`
2. Add a language test-script in `lang/<new-language>.sh`
3. Add an example solution in `days/day-00-example/solutions/example.<new-language>`
4. Make a PR to `main`-branch.
5. One of the maintainers will push a new docker-image to dockerhub.com, based on your PR.
6. ...then make sure Github workflows uses the new docker-image.
7. ...then merge the PR.

## How are solutions tested?

Every solution gets the `io/*.input`-files for a given day delivered to `stdin`, using `cat`. Whatever is written to `stdout` by the solution, is then compared for equality against `io/*.output`-files, using `diff`. This is identical for every language.

```sh
#!/usr/bin/env bash
cat day-03/io/my.input | <solution-in-any-language> | diff - day-03/io/my.output
```

See [day-00-example/solutions/](https://github.com/Arxcis/adventofcode2020/tree/main/days/day-00-example/solutions), for examples on how to read from `stdin` and how to write to `stdout` in different languages.
