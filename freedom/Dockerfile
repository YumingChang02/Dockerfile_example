FROM ubuntu:latest

RUN apt update && \
    apt install -y \
    build-essential \
    device-tree-compiler \
    g++ \
    gcc \
    git \
    libcapture-tiny-perl \
    libyaml-perl \
    libxml-simple-perl \
    nano \
    openjdk-11-jdk \
    perl \
    python \
    wget \
  && rm -rf /var/lib/apt/lists/*

# preparations
WORKDIR /opt
RUN mkdir riscv
RUN [ "/bin/bash", "-c", "set -o pipefail && wget -qO- https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.2.0-2019.05.3-x86_64-linux-ubuntu14.tar.gz | tar -xz --strip 1" ]
ENV RISCV=/opt/riscv/

WORKDIR /source
ENTRYPOINT [ "/bin/bash" ]
