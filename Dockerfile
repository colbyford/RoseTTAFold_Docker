# FROM phusion/baseimage:focal-1.0.0
FROM nvidia/cuda:11.4.1-base-ubuntu20.04

LABEL authors="Colby Ford <colby.ford@uncc.com>"

## Install System Dependencies
RUN apt-get update && \
    apt-get install -y \
    sudo \
    wget \
    git \
    python3 \
    python3-pip \
    python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

## Download RoseTTAFold from GitHub
RUN git clone https://github.com/RosettaCommons/RoseTTAFold.git && \
    cd RoseTTAFold

WORKDIR RoseTTAFold

## Create Conda Environments
RUN conda env create -f RoseTTAFold-linux.yml && \
    conda env create -f folding-linux.yml

## Download Model Weights
# RUN wget https://files.ipd.uw.edu/pub/RoseTTAFold/weights.tar.gz && \
#     tar xfz weights.tar.gz