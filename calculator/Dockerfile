FROM ubuntu:latest
RUN apt update && \
    apt install -y \
    python \
  && rm -rf /var/lib/apt/lists/*
COPY calc.py /
ENTRYPOINT [ "/usr/bin/python", "/calc.py" ]
CMD [ "1+1" ]