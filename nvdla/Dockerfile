FROM nvdla/vp
#MAINTAINER

## NOTE :
## Due to a potential bug, "cat /etc/resolv.conf" is added to each line that requires dns resolving,
## which temporary solves the dns bugs on ubuntu based images, if the bug is fixed, all "cat /etc/resolv.conf"
## can be safely removed, example will be `sed -i 's/cat \/etc\/resolv.conf && //g' Dockerfile`

ARG kernelver=4.13.3

RUN apt update && apt upgrade -y && apt install git && apt autoremove -y && apt autoclean

# prepare source codes
WORKDIR /usr/local/nvdla
RUN git clone -b master https://github.com/nvdla/vp.git
RUN git clone -b master https://github.com/nvdla/hw.git
RUN git clone -b master https://github.com/nvdla/sw.git
RUN [ "/bin/bash", "-c", "set -o pipefail && wget -qO- https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-$kernelver.tar.xz | tar -xJ -C /"]

# prepare libraries
RUN mkdir -p /usr/local/nvdla/vp/models/nvdla_hw_cmod/cmod
RUN ln -s /usr/local/nvdla/hw/cmod/include/ /usr/local/nvdla/vp/models/nvdla_hw_cmod/cmod/
RUN [ "/bin/bash", "-c", "set -o pipefail && wget --no-check-certificate  -qO- \
    https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz | \
    tar -xJ -C /" ]

# set compile enviroments
RUN echo "CROSS_COMPILE=/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin" >> /root/.bashrc
RUN echo "export PATH=/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin:$PATH" >> /root/.bashrc

# set KMD debug flag
RUN sed -i '/DEBUG_NETWORK_DATA/s/0/1/g' sw/kmd/firmware/include/dla_debug.h
RUN [ "/bin/bash", "-c", "export KDIR=/linux-$kernelver && \
                          export ARCH=arm64 && \
                          export CROSS_COMPILE=/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- && \
                          cd /linux-$kernelver && make defconfig && \
                          make prepare && make scripts && \
                          cd /usr/local/nvdla/sw/kmd && \
                          make -j $(nproc)" ]
RUN cp /usr/local/nvdla/sw/kmd/port/linux/opendla.ko /usr/local/nvdla

WORKDIR /usr/local/nvdla/
ENTRYPOINT ["/bin/bash"]
