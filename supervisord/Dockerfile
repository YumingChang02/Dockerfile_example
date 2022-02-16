FROM ubuntu:20.04
MAINTAINER yoto@goedge.ai

ARG USERNAME="YOUR_USERNAME"
ARG PASSWD="YOUR_PASSWORD"
ARG WORKSPACE="/workspace"

# set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Change mirror to TWCC for faster downloading speeds
RUN sed -i "s/security.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list
RUN sed -i "s/archive.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list

# install dependencies
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        locales \
        nano \
        nginx \
        openssl \
        sudo \
        supervisor \
        uwsgi \
        python3-pip \
    && \ 
    rm -rf /var/lib/apt/lists/*

# Allow access to supervisord over port 9001/tcp
RUN bash -c "printf '\n[inet_http_server]\nport=0.0.0.0:9001\n' | tee -a /etc/supervisor/supervisord.conf"
COPY nginx.conf /etc/supervisor/conf.d/nginx.conf

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
