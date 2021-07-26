FROM ubuntu:20.04

ARG USERNAME="YOUR_USERNAME"
ARG PASSWD="YOUR_PASSWORD"
ARG WORKSPACE="/workspace"

RUN sed -i "s/security.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list
RUN sed -i "s/archive.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list

ENV TZ="Asia/Taipei"

RUN apt update && \
    DEBIAN_FRONTEND="noninteractive" apt upgrade -y && \
    DEBIAN_FRONTEND="noninteractive" apt install -y \
        build-essential \
        ccache \
        ecj \
        fastjar \
        file \
        g++ \
        gawk \
        gettext \
        git \
        java-propose-classpath \
        libelf-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libssl-dev \
        locales \
        nano \
        openssl \
        python \
        python2.7-dev \
        python3 \
        python3-distutils \
        python3-setuptools \
        python3-dev \
        qemu-utils \
        rsync \
        subversion \
        swig \
        time \
        unzip \
        wget \
        xsltproc \
        zlib1g-dev \
        sudo

# preparations
RUN sed -i "s/#\ en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# add user
RUN useradd -rm -s /bin/bash -g root -G sudo -u 1000 -p "$(openssl passwd -1 $PASSWD)" $USERNAME

# allow sudo
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

#sync repo
RUN mkdir $WORKSPACE
RUN chown -R $USERNAME $WORKSPACE
WORKDIR $WORKSPACE
USER $USERNAME

ENTRYPOINT [ "/bin/bash" ]
