FROM alpine:latest
RUN apk update && apk add py-pip
RUN pip install speedtest-cli
ENTRYPOINT speedtest-cli