FROM ubuntu:latest
LABEL source=https://github.com/Arxcis/adventofcode2020

# Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ap-get install all the things
RUN apt-get update && apt-get install -yqq\
  python3\
  golang\
  nodejs\
  rustc;

