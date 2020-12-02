FROM ubuntu:20.10
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# apt-get install all the things
RUN apt-get update && apt-get install -yqq\
  # build-essential includes make, gcc and g++
  build-essential\
  default-jdk\
  golang\
  nodejs\
  php-cli\
  polyml libpolyml-dev\
  python3\
  ruby\
  rustc\
  wget\
  &&\
  wget https://github.com/dryzig/zig-debian/releases/download/0.6.0-1/zig_0.6.0-1_amd64.deb && dpkg -i zig_0.6.0-1_amd64.deb\
;