# FROM phusion/baseimage:focal-1.0.0
FROM nvidia/cuda:11.4.1-base-ubuntu20.04

LABEL authors="Colby Ford <colby.ford@uncc.com>"

## Install System Dependencies
RUN apt-get update && \
    apt-get install -y \
    sudo \
    wget \
    git \
    nano \
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
RUN wget https://files.ipd.uw.edu/pub/RoseTTAFold/weights.tar.gz && \
    tar xfz weights.tar.gz

## Install Third-Party Dependencies
RUN ./install_dependencies.sh

## Download Sequence Databases
# ### uniref30 [46G]
# RUN wget http://wwwuser.gwdg.de/~compbiol/uniclust/2020_06/UniRef30_2020_06_hhsuite.tar.gz && \
#     mkdir -p UniRef30_2020_06 && \
#     tar xfz UniRef30_2020_06_hhsuite.tar.gz -C ./UniRef30_2020_06

# ### BFD [272G]
# RUN wget https://bfd.mmseqs.com/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt.tar.gz && \
#     mkdir -p bfd && \
#     tar xfz bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt.tar.gz -C ./bfd

# ### structure templates (including *_a3m.ffdata, *_a3m.ffindex) [over 100G]
# RUN wget https://files.ipd.uw.edu/pub/RoseTTAFold/pdb100_2021Mar03.tar.gz && \
#     tar xfz pdb100_2021Mar03.tar.gz

## Install PyRosetta License
RUN wget --user=levinthal --password=paradox https://graylab.jhu.edu/download/PyRosetta4/archive/release/PyRosetta4.Release.python39.ubuntu/PyRosetta4.Release.python39.ubuntu.release-293.tar.bz2 && \
    tar -vjxf PyRosetta4.Release.python39.ubuntu.release-293.tar.bz2 && \
    cd PyRosetta4.Release.python39.ubuntu.release-293 && \
    python PyRosetta4.Release.python39.ubuntu.release-293/setup/ez_setup.py