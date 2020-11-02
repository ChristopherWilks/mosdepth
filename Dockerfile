FROM ubuntu

#largely from the mosdepth/scripts/install.sh script

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yy install bwa make build-essential cmake libncurses-dev ncurses-dev libbz2-dev lzma-dev liblzma-dev curl  libssl-dev libtool autoconf automake libcurl4-openssl-dev git

WORKDIR /
RUN git clone -b devel --depth 1 git://github.com/nim-lang/nim nim-devel/
WORKDIR nim-devel
RUN sh build_all.sh

ENV PATH="$PATH:/nim-devel/bin"

WORKDIR /
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN DEBIAN_FRONTEND=noninteractive apt-get update -yy
RUN DEBIAN_FRONTEND=noninteractive apt-get -yy install git llvm curl wget libcurl4-openssl-dev

WORKDIR /
RUN git clone https://github.com/38/d4-format
WORKDIR /d4-format
RUN ~/.cargo/bin/cargo build --release
#RUN cp /d4-format/target/release/libd4binding.* /usr/local/lib
RUN cp /d4-format/d4binding/include/d4.h /usr/local/include/
RUN ldconfig

#RUN mkdir /mosdepth
#COPY *.nim* /mosdepth/
#COPY *.cfg /mosdepth/
#WORKDIR /mosdepth
#RUN nimble refresh

#do this in mosdepth dir
#RUN /nim-devel/bin/nimble install -y
