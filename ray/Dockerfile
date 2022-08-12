FROM ubuntu:22.04

ARG USERNAME="YOUR_USERNAME"
ARG PASSWD="YOUR_PASSWORD"
ARG WORKSPACE="/workspace"
ARG UID="1000"
ENV TZ="Asia/Taiei"

RUN sed -i "s/security.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list
RUN sed -i "s/archive.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        locales \
        nano \
        openssl \
        python3-pip \
        ssh \
        sudo \
    && rm -rf /var/lib/apt/lists/* \
    && pip install ray

# preparations
RUN sed -i "s/#\ en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# add user
RUN useradd -rm -s /bin/bash -g root -G sudo -u $UID -p "$(openssl passwd -1 $PASSWD)" $USERNAME

# allow sudo
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

#sync repo
RUN mkdir $WORKSPACE
RUN chown -R $USERNAME $WORKSPACE
WORKDIR $WORKSPACE
USER $USERNAME

# Generate keys
RUN yes "" | ssh-keygen
RUN cat ~/.ssh/id_rsa.pub

# Start SSH
USER root
RUN mkdir /run/sshd
ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]
