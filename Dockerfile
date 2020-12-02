FROM ubuntu:20.10
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Configure repository for zig
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

# apt-get install all the things
RUN apt-get update && apt-get install -yqq\
  # build-essential includes `make`, `gcc` and `g++`
  build-essential\
  default-jdk\
  golang\
  nodejs\
  php-cli\
  polyml libpolyml-dev\
  zig;
  python3\
  ruby\
  rustc\
;

