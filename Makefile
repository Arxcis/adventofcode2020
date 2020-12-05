export DOCKER_TAG="jonasjso/adventofcode2020:2020-12-04-with-polyc-fix"



.PHONY:
	test\
	test.all\
	test.versions\
	docker.test\
	docker.all\
	docker.build\
	docker.push\
	docker.versions\
	versions\
	workflows\
	;\

test.all:
	for day in $$(ls days); do ./days/$$day/test.sh; done

test.versions:
	./scripts/print-versions.sh

test:
	./days/$(DAY)/test.sh

test.example:
	make test DAY=day-00-example

test.day00: test.example

test.day01:
	make test DAY=day-01
test.day02:
	make test DAY=day-02
# ...and so on. The list continues at the bottom of the Makefile.

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
	docker run -ti --env DAY=$(DAY) -v $(PWD):/test $(DOCKER_TAG) /bin/bash -c "cd /test && make test && exit"

docker.example:
	make docker.test DAY=day-00-example

docker.day00: docker.example

docker.day01:
	make docker.test DAY=day-01
docker.day02:
	make docker.test DAY=day-02
# ...and so on. The list continues at the bottom of the Makefile.

docker.all:
	docker run -ti -v $(PWD):/test $(DOCKER_TAG) /bin/bash -c "cd /test && make test.all && exit"

docker.build: Dockerfile
	docker build . --tag $(DOCKER_TAG)

docker.push:
	docker push $(DOCKER_TAG)

docker.versions:
	docker run -ti -v $(PWD):/test $(DOCKER_TAG) /bin/bash -c "cd /test && make versions"

versions:
	./scripts/print-versions.sh

workflows:
	./scripts/make-workflows.sh

# ...continuing where we left off
test.day03:
	make test DAY=day-03
test.day04:
	make test DAY=day-04
test.day05:
	make test DAY=day-05
test.day06:
	make test DAY=day-06
test.day07:
	make test DAY=day-07
test.day08:
	make test DAY=day-08
test.day09:
	make test DAY=day-09

# ...continuing where we left off
docker.day03:
	make docker.test DAY=day-03
docker.day04:
	make docker.test DAY=day-04
docker.day05:
	make docker.test DAY=day-05
docker.day06:
	make docker.test DAY=day-06
docker.day07:
	make docker.test DAY=day-07
docker.day08:
	make docker.test DAY=day-08
docker.day10:
	make docker.test DAY=day-10
