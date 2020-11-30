# Example: "make test DAY=day-03"
test-all:
	for day in $$(ls days); do "./days/$$day/test.sh"; done

test:
	./days/$(DAY)/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

dockertest:
	docker run -ti -v $(PWD):/test jonasjso/adventofcode2020:latest /bin/bash -c "cd /test && make && exit"

versions:
	./scripts/print-versions.sh

.PHONY: dockerbuild dockerpush test test-all versions dockertest
