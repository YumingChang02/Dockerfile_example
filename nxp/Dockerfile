FROM ubuntu:bionic

ARG GIT_EMAIL="yumingchang.cs03@g2.nctu.edu.tw"
ARG GIT_NAME="yumingchang"
ARG USERNAME="markchang"
ARG PASSWD="nxp"
ARG WORKSPACE="/workspace"

RUN apt update && \
    apt install -y \
        build-essential \
        chrpath \
        cpio \
        diffstat \
        gawk \
        gcc-multilib \
        git \
        libsdl1.2-dev\
        locales \
        nano \
        repo \
        socat \
        sudo \
        texinfo \
        unzip \
        wget \
  && rm -rf /var/lib/apt/lists/*

# preparations
RUN sed -i "s/#\ en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# add user
RUN useradd -rm -s /bin/bash -g root -G sudo -u 1000 -p "$(openssl passwd -1 $PASSWD)" $USERNAME
USER markchang
RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.name $GIT_NAME

#sync repo
WORKDIR $WORKSPACE

ENTRYPOINT [ "/bin/bash" ]
