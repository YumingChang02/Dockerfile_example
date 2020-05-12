FROM ubuntu:18.04

MAINTAINER tbp147@gmail.com <Bruce>

RUN apt update && apt upgrade -y && \
    apt install -y \
        cmake \
        g++ \
        git \
        libelf-dev \
        nano \
        wget \
        verilator \
        vim \
        xz-utils && \
    rm -rf /var/lib/apt/lists/*

# prepare systemC library
RUN mkdir -p /usr/src/systemc-2.3.0a
WORKDIR /usr/src/systemc-2.3.0a
RUN [ "/bin/bash", "-c", "set -o pipefail && wget -qO- http://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.0a.tar.gz | tar -zx --strip 1" ]
RUN mkdir -p /usr/local/systemc-2.3.0 && \
    mkdir objdir && \
    cd objdir && \
    ../configure --prefix=/usr/local/systemc-2.3.0 && \
    make -j $(proc) && make install -j $(proc)

# get source
WORKDIR /
RUN [ "/bin/bash", "-c", "git clone https://github.com/ultraembedded/riscv.git" ]

WORKDIR /riscv
ENTRYPOINT ["/bin/bash"]
