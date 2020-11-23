test:
	./day00-example/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

versions:
	./scripts/versions.sh

.PHONY: dockerbuild dockerpush test versions

