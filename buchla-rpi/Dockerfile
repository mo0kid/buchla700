FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc g++ make \
    wget cpio unzip rsync bc \
    python3 python3-setuptools \
    file patch perl \
    libncurses-dev \
    git ca-certificates \
    dosfstools mtools genext2fs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /repo
