test-all:
	for day in $$(ls days); do ./days/$$day/test.sh; done

test:
	./days/$(DAY)/test.sh

test.example:
	make test DAY=day-00-example


dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

#
# make dockertest DAY=<day>
#
# Run all the tests for a day inside a docker container. Should work out of the box, if you already have docker installed.
#
#   Example: make dockertest DAY=day-03
#
# Benefit 1: Avoids having to install all languages on the host machine.
# Benefit 2: Reproduceability - Makes sure tests run with the same versions on any machine, regardless of what is installed on the host machine.
#
dockertest:
	docker run -ti --env DAY=$(DAY) -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make test && exit"

dockertest.example:
	make dockertest DAY=day-00-example

#
# make dockertest-all
#
# Run all tests for all days inside a docker container.
#
dockertest-all:
	docker run -ti -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make && exit"

versions:
	./scripts/print-versions.sh

.PHONY: dockerbuild dockerpush test test-all versions dockertest dockertest-all
