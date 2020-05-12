from espressif/idf:latest

ARG USERNAME="markchang"
ARG PASSWD="5;u.4au/6"

RUN apt update && \
    apt install -y \
        locales \
        openssl \
        sudo \
     && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/#\ en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN useradd -rm -s /bin/bash -g root -G sudo -u 1000 -p "$(openssl passwd -1 $PASSWD)" $USERNAME
USER $USERNAME

RUN echo ". $IDF_PATH/export.sh" >> /home/$USERNAME/.bashrc

ENTRYPOINT [ "/bin/bash" ]
