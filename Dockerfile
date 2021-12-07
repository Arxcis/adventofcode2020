FROM ubuntu:20.04
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 2. Build things from source first, so get build deps installed
RUN apt-get update && apt-get install -yqq --no-install-recommends\
  # build-essential includes `make`, `gcc` and `g++`
  build-essential git wget ca-certificates curl unzip

# 3. Install polyml compiler, from github.com
RUN git clone https://github.com/polyml/polyml.git /tmp/polyml && cd /tmp/polyml\
  && CFLAGS=-no-pie ./configure --prefix=/usr\
  && make && make compiler && make install\
  && rm -rf /tmp/*

# 4. Tell apt to install node.js from nodesource.com
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

# 5. Install deno.ts run-time from deno.land
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.16.4\
    && cp ~/.deno/bin/deno /bin/\
    && rm -rf ~/.deno/*

# 6. Install zig compiler, from ziglang.org
RUN cd /tmp && wget https://ziglang.org/builds/zig-linux-x86_64-0.9.0-dev.1919+0812b5746.tar.xz\
  && tar xf zig-linux-x86_64-0.9.0-dev.1919+0812b5746.tar.xz\
  && mkdir -p /bin/lib\
  && cp "zig-linux-x86_64-0.9.0-dev.1919+0812b5746/zig" /bin/\
  && cp -ru zig-linux-x86_64-0.9.0-dev.1919+0812b5746/lib/* /bin/lib/\
  && chmod ugo+x /bin/zig\
  && rm -rf /tmp/*

# 7. Install all other compilers, from apt-get
RUN apt-get update && apt-get install -yqq --no-install-recommends\
    golang php-cli nodejs python3 ruby rustc \
    # https://root-forum.cern.ch/t/cannot-load-libtinfo-so-5-on-ubuntu-18-04-2/33195
    # Cleanup what we don't need
    && rm -rf /var/lib/apt/lists/*\
    && apt-get autoremove -yqq git wget
