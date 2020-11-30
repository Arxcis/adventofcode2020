test-all:
	for day in $$(ls days); do ./days/$$day/test.sh; done

# Example: "make test DAY=day-03"
test:
	./days/$(DAY)/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

# Example: "make dockertest DAY=day-03"
dockertest:
	docker run -ti --env DAY=$(DAY) -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make test && exit"

dockertest-all:
	docker run -ti -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make && exit"

versions:
	./scripts/print-versions.sh

.PHONY: dockerbuild dockerpush test test-all versions dockertest dockertest-all
