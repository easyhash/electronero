
FROM ubuntu:xenial

# Get needed packages
RUN set -x \
  && buildDeps=' \
      ca-certificates \
      cmake \
      g++ \
      git \
      libboost-all-dev \
      libssl-dev \
      make \
      pkg-config \
      build-essential \
      libzmq3-dev \
      wget \
      libunbound-dev \
      libsodium-dev \
      libminiupnpc-dev \
      libunwind8-dev \
      liblzma-dev \
      libreadline6-dev \
      libldns-dev \
      libexpat1-dev \
      doxygen \
      graphviz \
  ' \
  && apt-get -qq update \
  && apt-get -qq install $buildDeps


# Create app directory
RUN mkdir -p /daemon && mkdir -p /daemon/data && mkdir -p /daemon

# Install Daemon
WORKDIR /daemon/
RUN git clone https://github.com/electronero/electronero.git src
WORKDIR /daemon/src/
RUN make -j$(nproc)

RUN mv /daemon/src/build/release/bin/* /daemon && rm -rf /daemon/src
WORKDIR /daemon/

EXPOSE  18081 18082