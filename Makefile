test.all:
	for day in $$(ls days); do ./days/$$day/test.sh; done

test:
	./days/$(DAY)/test.sh

test.example:
	make test DAY=day-00-example

test.day01:
	make test DAY=day-01
test.day02:
	make test DAY=day-02

#
# make docker.test DAY=<day>
#
# Run all the tests for a day inside a docker container. Should work out of the box, if you already have docker installed.
#
#   Example: make docker.test DAY=day-03
#
# Benefit 1: Avoids having to install all languages on the host machine.
# Benefit 2: Reproduceability - Makes sure tests run with the same versions on any machine, regardless of what is installed on the host machine.
#
docker.test:
	docker run -ti --env DAY=$(DAY) -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make test && exit"

docker.example:
	make docker.test DAY=day-00-example

docker.day01:
	make docker.test DAY=day-01
docker.day02:
	make docker.test DAY=day-02

docker.all:
	docker run -ti -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make && exit"

docker.build: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

docker.push:
	docker push jonasjso/adventofcode2020:latest

versions:
	./scripts/print-versions.sh

.PHONY:
	dockerbuild\
	dockerpush\
	test\
	test.all\
	docker.test\
	docker.all\
	docker.build\
	docker.push\
	versions;\
