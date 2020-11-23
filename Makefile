test:
	echo "hello test"

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest


.PHONY: dockerbuild dockerpush test

