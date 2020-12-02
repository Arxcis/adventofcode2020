FROM ubuntu:20.04
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
;

RUN wget https://ziglang.org/download/0.7.0/zig-linux-x86_64-0.7.0.tar.xz\
  && tar xvf zig-linux-x86_64-0.7.0.tar.xz\
  && cp zig-linux-x86_64-0.7.0/zig /bin/\
;