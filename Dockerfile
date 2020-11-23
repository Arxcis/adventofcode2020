FROM ubuntu:latest
LABEL github=https://github.com/Arxcis/adventofcode2020

# Apt install all the things
RUN apt update && apt install -yqq\
	python3\
	python-is-python3\
	;

