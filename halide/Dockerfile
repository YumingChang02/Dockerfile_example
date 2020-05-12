FROM ubuntu:18.04

RUN apt update && apt upgrade -y && \
    apt install -y \
        clang-8 \
        libpng-dev \
        libjpeg-dev \
        make \
        nano \
        g++ \
        gcc \
        git \
        vim \
    && rm -rf /var/lib/apt/lists/*

# download halide
WORKDIR /usr/src
RUN git clone https://github.com/halide/Halide.git
RUN mkdir /usr/src/Halide/build

# install Halide
ENV LLVM_CONFIG /usr/bin/llvm-config-8
ENV CLANG /usr/bin/clang-8
WORKDIR /usr/src/Halide/build
RUN make -f ../Makefile -j $(nproc)

# set enviroment variable
ENV LD_LIBRARY_PATH=/usr/src/Halide/build/distrib/bin

WORKDIR /
ENTRYPOINT [ "/bin/bash" ]
