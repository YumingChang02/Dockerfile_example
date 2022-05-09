FROM library/archlinux
MAINTAINER yoto@goedge.ai

ARG ARIA2_DOWNLOAD="/download"
ARG UID="1000"
ENV TZ="Asia/Taiei"

RUN sed -i '1s/^/Server = http:\/\/free.nchc.org.tw\/arch\/$repo\/os\/$arch\n/' /etc/pacman.d/mirrorlist

RUN pacman -Syyu --noconfirm && \
    pacman -Sy --noconfirm \
      aria2 \
      nano \
      openssl \
      sudo \
    && \
    rm /var/cache/pacman/pkg/*

ARG USERNAME="YOUR_USERNAME"
ARG PASSWD="YOUR_PASSWORD"

# add user
RUN useradd -rm -s /bin/bash -g root -G wheel -u $UID -p "$(openssl passwd -1 $PASSWD)" $USERNAME

# allow sudo
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

# create download path
RUN mkdir -p $ARIA2_DOWNLOAD
USER $USERNAME
WORKDIR $ARIA2_DOWNLOAD

ENTRYPOINT [ "/usr/bin/aria2c", "--conf-path=/config/aria2.conf.main" ]
