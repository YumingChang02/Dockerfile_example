FROM ubuntu:latest
MAINTAINER BT

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        git \
		g++ \
		vim \
		nano \
		curl \
		cmake \
		unzip \
        python3=3.6.5-3 \
		clang-3.9 \
		python3-pip \
		python3-dev \
		python3-venv \
		zlib1g \
        zlib1g-dev \
        libtinfo-dev \
        dh-autoreconf \
		build-essential \
		clang-format-3.9 \
		protobuf-compiler \
		libprotobuf-dev \
        && \
    apt autoremove -y && \
    apt autoclean

# ngraph library
WORKDIR /

RUN [ "/usr/bin/git", "clone", "https://github.com/NervanaSystems/ngraph.git" ]

WORKDIR /ngraph
RUN [ "/usr/bin/git", "checkout", "v0.9.0" ]

RUN [ "/bin/mkdir", "-p", "/ngraph/build" ]

WORKDIR /ngraph/build

RUN [ "/bin/bash", "-c", "cmake .. -DNGRAPH_ONNX_IMPORT_ENABLE=ON -DCMAKE_INSTALL_PREFIX=/ngraph_dist" ]
RUN [ "/bin/bash", "-c", "make -j $(nproc) && make install" ]

# ngraph with onnx
WORKDIR /ngraph/python
RUN [ "/usr/bin/git", "clone", "--recursive", "-b", "allow-nonconstructible-holders", "https://github.com/jagerman/pybind11.git" ]
ARG PYBIND_HEADERS_PATH=/ngraph/python/pybind11
ARG NGRAPH_CPP_BUILD_PATH=/ngraph_dist
RUN [ "/bin/bash", "-c", "python3 setup.py bdist_wheel" ]

WORKDIR /ngraph

RUN [ "/bin/bash", "-c", "/usr/bin/env python3 -m venv onnx && cd onnx/ && . bin/activate && pip install -U /ngraph/python/dist/ngraph-0.9.0-cp36-cp36m-linux_x86_64.whl && pip install git+https://github.com/NervanaSystems/ngraph-onnx/ && pip install --upgrade --force-reinstall onnx --no-binary onnx && pip install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp36-cp36m-linux_x86_64.whl && pip3 install torchvision && pip install tqdm matplotlib" ]

ENTRYPOINT ["/bin/bash"]
