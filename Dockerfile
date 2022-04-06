FROM ubuntu:latest
MAINTAINER Joakim Bech (joakim.bech@linaro.org)

# This is needed on later Ubuntu distros to be able to install the i386
# packages.
# RUN dpkg --add-architecture i386

# Solution : Error when bootstrapping CMake: Problem while running initial CMake
ENV CC=path_of_gcc/gcc-version
ENV CXX=path_of_g++/g++-version

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata


RUN  apt update && apt install -y  \
	    android-tools-adb \
	    android-tools-fastboot \
	    autoconf \
	    bc \
	    bison \
	    cscope \
	    curl \
	    flex \
	    gdisk \
	    git \
	    libfdt-dev \
	    libftdi-dev \
	    libglib2.0-dev \
	    libhidapi-dev \
	    libncurses5-dev \
	    libpixman-1-dev \
	    libtool \
	    make \
	    mtools \
	    netcat \
	    python \
	    python3-crypto \
	    python3-pycryptodome \
	    python3-serial \
	    python3-wand \
	    python3-pyelftools \
	    tmux \
	    unzip \
	    uuid-dev \
	    xdg-utils \
	    xterm \
	    xz-utils \
	    vim \
	    zlib1g-dev \
	    g++ \
	    rsync \
	    libssl-dev \
	    wget \
	    pkg-config \
	    cpio \
	    meson \
	    libgmp3-dev \
	    libmpc-dev \
	    iasl \
	    python3-cryptography

# Download repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo
RUN chmod a+x /bin/repo

RUN useradd --create-home --shell /bin/bash optee
RUN echo 'optee:optee' | chpasswd
RUN echo 'root:optee*' | chpasswd

USER optee

# Configure git so repo won't complain later on
RUN git config --global user.name "OP-TEE"
RUN git config --global user.email "op-tee@linaro.org"

RUN mkdir -p /home/optee/qemu-optee
WORKDIR /home/optee/qemu-optee

RUN sh -c "echo y | /bin/repo init -u https://github.com/OP-TEE/manifest.git"
RUN /bin/repo sync -j3

WORKDIR /home/optee/qemu-optee/build
RUN make toolchains -j1 --fail-fast

#RUN make -j4 all run
