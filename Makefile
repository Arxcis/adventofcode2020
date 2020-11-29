# Example: "make test DAY=day-03"
test:
	./scripts/print-versions.sh;
	./$(DAY)/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

versions:
	./scripts/print-versions.sh

workflows:
	./scripts/make-workflows.sh

folders:
	./scripts/make-folders.sh

.PHONY: dockerbuild dockerpush test versions workflows folders
