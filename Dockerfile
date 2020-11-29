FROM ubuntu:21.04
LABEL source=https://github.com/Arxcis/adventofcode2020

# Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# apt-get install all the things
RUN apt-get update && apt-get install -yqq\
  # For 'make'
  build-essential\
  python3\
  golang\
  nodejs\
  rustc;
