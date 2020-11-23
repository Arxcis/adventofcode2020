test:
	./day-00-example/test.sh

dockerbuild: Dockerfile
	docker build . --tag jonasjso/adventofcode2020

dockerpush:
	docker push jonasjso/adventofcode2020:latest

versions:
	./scripts/print-versions.sh

workflows:
	./scripts/make-workflows.sh

scaffold:
	./scripts/make-scaffold.sh

.PHONY: dockerbuild dockerpush test versions workflows scaffold
