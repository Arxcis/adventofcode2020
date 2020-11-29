# Example: "make test DAY=day-03"
test-all:
	for day in $$(ls days); do "./days/$$day/test.sh"; done

test:
	./days/$(DAY)/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

versions:
	./scripts/print-versions.sh

.PHONY: dockerbuild dockerpush test test-all versions
