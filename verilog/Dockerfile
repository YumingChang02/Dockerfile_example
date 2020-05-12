FROM ubuntu:latest
#MAINTAINER

#ARG kernelver=4.13.3

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        git \
        build-essential \
        default-jdk \
        wget \
        clang \
        libexpat1-dev \
        verilator \
        && \
    apt autoremove -y && \
    apt autoclean && \
	rm -rf /var/lib/apt/lists/*

# build systemc2.3.0
WORKDIR /
RUN [ "/bin/bash", "-c", "set -o pipefail && wget -qO- \
      http://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.0a.tar.gz | \
      tar -xz -C /" ]
RUN [ "/bin/bash", "-c", "mkdir /systemc-2.3.0a/build" ]

WORKDIR /systemc-2.3.0a/build
RUN [ "/bin/bash", "-c", "mkdir /usr/local/systemc-2.3.0/" ]
RUN [ "/bin/bash", "-c", "../configure --prefix=/usr/local/systemc-2.3.0/ && make -j 8 && make install" ]

# install perl modules
RUN yes | /usr/bin/cpan YAML
RUN [ "/usr/bin/cpan", "IO::Tee" ]
RUN [ "/usr/bin/cpan", "XML::Simple" ]
RUN [ "/usr/bin/cpan", "Capture::Tiny" ]

WORKDIR /nvdla
ENTRYPOINT ["/bin/bash"]
