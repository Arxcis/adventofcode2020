FROM ubuntu:20.10
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 2. apt install all the things
RUN apt-get update && apt-get install -yqq --no-install-recommends\
  # build-essential includes `make`, `gcc` and `g++`
  build-essential\
  default-jdk\
  golang\
  nodejs\
  php-cli\
  polyml libpolyml-dev\
  python3\
  ruby\
  rustc\
  && \
  # Cleanup what we don't need
  rm -rf /var/lib/apt/lists/* \ 
  && \
  apt-get autoremove \
  ;

