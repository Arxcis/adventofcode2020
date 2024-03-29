include .env

.PHONY: test versions build login push

# Test everything:
# 	- make
#
# Test year:
# 	- make name=(2021|2020)
#
# Test day:
#   - make name=(2021|2020)/(day01|day02|day03|day04|...)
#
test:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./$(name)/test.sh && exit"

versions:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./scripts/print-versions.sh && exit"

build: Dockerfile
	docker build . --tag $(DOCKER_TAG)

login:
	docker login

push:
	docker push $(DOCKER_TAG)
