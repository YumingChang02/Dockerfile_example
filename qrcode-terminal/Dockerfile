FROM alpine

RUN apk add --no-cache npm && npm install -g qrcode-terminal

ENTRYPOINT [ "/usr/bin/qrcode-terminal" ]
