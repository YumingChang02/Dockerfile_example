FROM ubuntu:20.04

ARG SUPERVISORD_CONF="/etc/supervisor/conf.d/"

# set timezone
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Change mirror to TWCC for faster downloading speeds
RUN sed -i "s/security.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list
RUN sed -i "s/archive.ubuntu.com/free.nchc.org.tw/g" /etc/apt/sources.list

# install dependencies
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        apache2-utils \
        nano \
        nginx \
        iproute2 \
        iputils-ping \
        vim \
        python3-pip \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip install supervisor

RUN mkdir -p $SUPERVISORD_CONF
RUN echo_supervisord_conf | tee /etc/supervisor/supervisord.conf && \
    echo "\n[include]\nfiles = /etc/supervisor/conf.d/*.ini" | tee -a /etc/supervisor/supervisord.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.ini $SUPERVISORD_CONF
COPY supervisord.ini $SUPERVISORD_CONF

ENV USERNAME="test"
ENV NGINX_SHARE="/workspace/share"
RUN mkdir -p $NGINX_SHARE

ENTRYPOINT htpasswd -c /etc/nginx/.htpasswd $USERNAME && \
           chown -R www-data $NGINX_SHARE && \
           chown -R www-data /etc/nginx/.htpasswd && \
           /usr/local/bin/supervisord -n -c /etc/supervisor/supervisord.conf
