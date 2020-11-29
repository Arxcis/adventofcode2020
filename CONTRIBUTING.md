# Contributing
1. Make a branch. Example: `git checkout -b jonas/day-03`
2. Write a solution, in the language of your choice. Example: `vim day-03/solutions/super-optimized.py`
3. Test your solution.

```sh
cat day-03/input.txt | python3 day-03/solutions/super-optimized.py | diff - day-03/output.txt
```

4. Make sure your solution is automatically tested by the Github CI, by adding a line of code to `day-03/test.sh`.
*Example line:*
```sh
$DIR/../../scripts/test-py.sh $DIR "solutions/super-optimized.py"
```

5. Make a Pull Request to the `main` branch.
6. Merge when the tests pass!

## How are solutions tested?

Every solution gets the `input`-challenge delivered to `stdin`, and every solution is expected to answer, by writing the `output`-answer to `stdout`.

```sh
#!/bin/bash
cat input.txt | <run-solution> | diff - output.txt
```
See `day-00-example/solutions/`, for examples on how to read from `stdin` and how to write to `stdout` in different languages.


## How do I add support for a programming language?

To add a support for a new language:
1. Add a line to the Dockerfile: `apt install <the language you want>`.
2. Add a test-script: `touch ./scripts/test-<the-language-you-want>.sh`.
3. Make a PR, and we will merge the PR, build and upload a new container to Dockerhub ASAP!

