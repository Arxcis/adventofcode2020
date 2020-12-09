export DOCKER_TAG="jonasjso/adventofcode2020:2020-12-07-with-deno"

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
	./test.sh

test.versions:
	./scripts/print-versions.sh

test:
	./days/$(DAY)/test.sh

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


# Aliases for all days running on host machine
test.example:
	make test DAY=day-00-example
test.day00:
	make test DAY=day-00-example
test.day01:
	make test DAY=day-01
test.day02:
	make test DAY=day-02
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
test.day10:
	make test DAY=day-10
test.day11:
	make test DAY=day-11
test.day12:
	make test DAY=day-12
test.day13:
	make test DAY=day-13
test.day14:
	make test DAY=day-14
test.day15:
	make test DAY=day-15
test.day16:
	make test DAY=day-16
test.day17:
	make test DAY=day-17
test.day18:
	make test DAY=day-18
test.day19:
	make test DAY=day-19
test.day20:
	make test DAY=day-20
test.day21:
	make test DAY=day-21
test.day22:
	make test DAY=day-22
test.day23:
	make test DAY=day-23
test.day24:
	make test DAY=day-24
test.day25:
	make test DAY=day-25

# Aliases for all days running in docker container
docker.example:
	make docker.test DAY=day-00-example
docker.day00:
	make docker.test DAY=day-00-example
docker.day01:
	make docker.test DAY=day-01
docker.day02:
	make docker.test DAY=day-02
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
docker.day09:
	make docker.test DAY=day-09
docker.day10:
	make docker.test DAY=day-10
docker.day11:
	make docker.test DAY=day-11
docker.day12:
	make docker.test DAY=day-12
docker.day13:
	make docker.test DAY=day-13
docker.day14:
	make docker.test DAY=day-14
docker.day15:
	make docker.test DAY=day-15
docker.day16:
	make docker.test DAY=day-16
docker.day17:
	make docker.test DAY=day-17
docker.day18:
	make docker.test DAY=day-18
docker.day19:
	make docker.test DAY=day-19
docker.day20:
	make docker.test DAY=day-20
docker.day21:
	make docker.test DAY=day-21
docker.day22:
	make docker.test DAY=day-22
docker.day23:
	make docker.test DAY=day-23
docker.day24:
	make docker.test DAY=day-24
docker.day25:
	make docker.test DAY=day-25
