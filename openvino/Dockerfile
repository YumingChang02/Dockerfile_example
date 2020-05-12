FROM ubuntu:18.04

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/16345/l_openvino_toolkit_p_2020.1.023.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer

WORKDIR /workspace

RUN usermod -aG video root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        build-essential \
        cmake \
        cpio \
        curl \
        gnupg2 \
        git \
        libdrm2 \
        libglib2.0-0 \
        lsb-release \
        libgtk-3-0 \
        libtool \
        ocl-icd-libopencl1 \
        pciutils \
        python3.6 \
        python3.6-dev \
        python3.6-venv \
        python3-distutils \
        python3-pip \
        sudo \
        udev \
        unzip \
        wget && \
    curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" && \
    python3.6 /tmp/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*


RUN pip3 install --no-cache-dir \
        paho-mqtt \
        numpy \
        requests \
        Flask \
        pytz \
        Pillow \
        networkx==2.3

RUN mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
    curl -LOJ "${DOWNLOAD_LINK}" && \
    tar -xzf ./*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    rm -rf $TEMP_DIR

RUN $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh

RUN $INSTALL_DIR/deployment_tools/model_optimizer/install_prerequisites/install_prerequisites.sh

RUN curl -L "https://github.com/intel/compute-runtime/releases/download/19.41.14441/intel-gmmlib_19.3.2_amd64.deb" --output "intel-gmmlib_19.3.2_amd64.deb" && \
    curl -L "https://github.com/intel/compute-runtime/releases/download/19.41.14441/intel-igc-core_1.0.2597_amd64.deb" --output "intel-igc-core_1.0.2597_amd64.deb" && \
    curl -L "https://github.com/intel/compute-runtime/releases/download/19.41.14441/intel-igc-opencl_1.0.2597_amd64.deb" --output "intel-igc-opencl_1.0.2597_amd64.deb" && \
    curl -L "https://github.com/intel/compute-runtime/releases/download/19.41.14441/intel-opencl_19.41.14441_amd64.deb" --output "intel-opencl_19.41.14441_amd64.deb" && \
    curl -L "https://github.com/intel/compute-runtime/releases/download/19.41.14441/intel-ocloc_19.41.14441_amd64.deb" --output "intel-ocloc_19.41.14441_amd64.deb" && \
    dpkg -i ./*.deb && \
    ldconfig && \
    rm ./*

RUN echo "source $INSTALL_DIR/bin/setupvars.sh" >> /root/.bashrc

ENV INSTALLDIR /opt/intel/openvino

WORKDIR /workspace

CMD ["/bin/bash"]
