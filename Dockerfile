FROM ubuntu:latest
LABEL github=https://github.com/Arxcis/adventofcode2020

# Configure TZ, so we don't get interactive prompt
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -yqq\
  curl\
  unzip;

# Tell ubuntu that we want to install node from nodesource
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -

# Install all the things
RUN apt update && apt install -yqq\
  # python3 v3.8.6
	python3\
  # golang 1.14
  golang\
  # nodejs v15.x
  nodejs

  # deno v1.5.3
RUN curl -fsSL https://deno.land/x/install/install.sh | sh\
  && mv -v /root/.deno/bin/* /bin/

# @TODO Enable rust support rust v1.48
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y\
 # && mv -v /root/.cargo/bin/* /bin/
