include .env

.PHONY: day-00-example

all:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./test.sh && exit"

versions:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./scripts/print-versions.sh && exit"

build: Dockerfile
	docker build . --tag $(DOCKER_TAG)

push:
	docker push $(DOCKER_TAG)


#
# 2020
#
day-00-example:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc &&  ./day-00-example/test.sh && exit"
2020.day-01:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-01/test.sh && exit"
2020.day-02:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-02/test.sh && exit"
2020.day-03:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-03/test.sh && exit"
2020.day-04:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-04/test.sh && exit"
2020.day-05:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-05/test.sh && exit"
2020.day-06:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-06/test.sh && exit"
2020.day-07:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-07/test.sh && exit"
2020.day-08:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-08/test.sh && exit"
2020.day-09:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-09/test.sh && exit"
2020.day-10:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-10/test.sh && exit"
2020.day-11:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-11/test.sh && exit"
2020.day-12:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-12/test.sh && exit"
2020.day-13:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-13/test.sh && exit"
2020.day-14:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-14/test.sh && exit"
2020.day-15:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-15/test.sh && exit"
2020.day-16:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-16/test.sh && exit"
2020.day-17:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-17/test.sh && exit"
2020.day-18:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-18/test.sh && exit"
2020.day-19:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-19/test.sh && exit"
2020.day-20:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-20/test.sh && exit"
2020.day-21:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-21/test.sh && exit"
2020.day-22:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-22/test.sh && exit"
2020.day-23:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-23/test.sh && exit"
2020.day-24:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-24/test.sh && exit"
2020.day-25:
	docker run -ti -v $(shell pwd):/aoc $(DOCKER_TAG) /bin/bash -c "cd /aoc && ./2020/day-25/test.sh && exit"

