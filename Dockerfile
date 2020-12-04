FROM ubuntu:20.04
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Build things from source first, so get build deps installed
RUN apt-get update && apt-get install -yqq --no-install-recommends\
  # build-essential includes `make`, `gcc` and `g++`
  build-essential git wget ca-certificates

RUN cd /opt && wget https://ziglang.org/download/0.7.0/zig-linux-x86_64-0.7.0.tar.xz\
  && tar xf zig-linux-x86_64-0.7.0.tar.xz\
  && rm -rf zig-linux-x86_64-0.7.0.tar.xz\
  && ln -s `pwd`/zig-linux-x86_64-0.7.0/zig /bin/zig\
  && chmod ugo+x /bin/zig

RUN git clone https://github.com/polyml/polyml.git /tmp/polyml && cd /tmp/polyml \
  && CFLAGS=-no-pie ./configure --prefix=/usr && make && make compiler && make install \
  && cd / && rm -rf /tmp/polyml

# 2. apt install all the things
RUN apt-get update && apt-get install -yqq --no-install-recommends\
    default-jdk golang nodejs php-cli python3 ruby rustc \
  # Cleanup what we don't need
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -yqq git wget
