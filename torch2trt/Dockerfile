FROM nvcr.io/nvidia/tensorrt:20.03-py3

RUN apt update && apt upgrade -y && \
    apt install -y \
    # packages to install here
    nano \
    locales \
  && rm -rf /var/lib/apt/lists/*

# set lang to en_US.UTF-8
RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8

# prepare pytorch and torch2trt
RUN pip install torch torchvision tqdm

WORKDIR /opt
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt && cd torch2trt && python setup.py install

# install Dr. Opt v1
RUN git clone https://github.com/NeuralScope/dropt-cli.git && cd dropt-cli && pip install .

ENTRYPOINT [ "/bin/bash" ]
