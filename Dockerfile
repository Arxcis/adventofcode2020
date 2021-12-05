FROM ubuntu:20.04
LABEL source=https://github.com/Arxcis/adventofcode2020

# 1. Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 2. Build things from source first, so get build deps installed
RUN apt-get update && apt-get install -yqq --no-install-recommends\
  # build-essential includes `make`, `gcc` and `g++`
  build-essential git wget ca-certificates curl unzip

# 3. Install zig compiler, from ziglang.org
RUN cd /tmp && wget https://ziglang.org/download/0.7.1/zig-linux-x86_64-0.7.1.tar.xz\
  && tar xf zig-linux-x86_64-0.7.1.tar.xz\
  && cp zig-linux-x86_64-0.7.1/zig /bin/zig\
  && chmod ugo+x /bin/zig\
  && rm -rf /tmp/*

# 4. Install polyml compiler, from github.com
RUN git clone https://github.com/polyml/polyml.git /tmp/polyml && cd /tmp/polyml\
  && CFLAGS=-no-pie ./configure --prefix=/usr\
  && make && make compiler && make install\
  && rm -rf /tmp/*

# 5. Tell apt to install node.js from nodesource.com
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

# 6. Install deno.ts run-time from deno.land
RUN curl -fsSL https://deno.land/x/install/install.sh | sh\
    && cp ~/.deno/bin/deno /bin/\
    && rm -rf ~/.deno/*

# 7. Install kotlinc-native
RUN cd /tmp && wget https://github.com/JetBrains/kotlin/releases/download/v1.5.32/kotlin-native-linux-x86_64-1.5.32.tar.gz\
    && tar xf kotlin-native-linux-x86_64-1.5.32.tar.gz\
    && mkdir -p /usr/tools /usr/klib /usr/dist /usr/sources /usr/konan\
    && cp -r kotlin-native-linux-x86_64-1.5.32/bin/* /bin/\
    && cp -r kotlin-native-linux-x86_64-1.5.32/tools/* /usr/tools\
    && cp -r kotlin-native-linux-x86_64-1.5.32/klib/* /usr/klib\
    && cp -r kotlin-native-linux-x86_64-1.5.32/dist/* /usr/dist\
    && cp -r kotlin-native-linux-x86_64-1.5.32/sources/* /usr/sources\
    && cp -r kotlin-native-linux-x86_64-1.5.32/konan/* /usr/konan\
    && chmod ugo+x /bin/kotlinc-native\
    && rm /bin/kotlinc\
    && rm -rf /tmp/*

COPY ./lib/minimal.kt /tmp/minimal.kt

# 8. Install all other compilers, from apt-get
RUN apt-get update && apt-get install -yqq --no-install-recommends\
    default-jdk golang php-cli nodejs python3 ruby rustc \
    # https://root-forum.cern.ch/t/cannot-load-libtinfo-so-5-on-ubuntu-18-04-2/33195
    libtinfo5\
    # "Downloading native dependencies (LLVM, sysroot etc). This is a one-time action performed only on the first run of the compiler."
    && kotlinc-native /tmp/minimal.kt -o /tmp/minimal.kt\
    # Cleanup what we don't need
    && rm -rf /tmp/*\
    && rm -rf /var/lib/apt/lists/*\
    && apt-get autoremove -yqq git wget

