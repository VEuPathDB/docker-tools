FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && apt-get install -y \
    wget \
    git \
    perl \
    gcc \
    build-essential \
    zlib1g-dev \
    cmake \
    python3 \
    python3-pip \
    curl \
    libncurses5-dev \
    libncursesw5-dev \
    libbz2-dev \
    liblzma-dev \
    autotools-dev \
    automake \
    libtool

ENV PREFIX_INSTALLATION=$HOME/CraiG
ENV CRAIG_HOME="${PREFIX_INSTALLATION}"
ENV REGTOOLS_HOME=$HOME/regtools
ENV PATH="${CRAIG_HOME}/bin:${CRAIG_HOME}/perl/bin:${CRAIG_HOME}/python/bin:${REGTOOLS_HOME}/build:${PATH}"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${CRAIG_HOME}/lib"

WORKDIR /tmp

# RUN export GIT_COMMIT_SHA=3068563a195739a6a81f77d033c3879ab1defcdc \
#     && cd $HOME \
#     && git clone https://github.com/griffithlab/regtools \
#     && cd regtools \
#     && git checkout $GIT_COMMIT_SHA \
#     && mkdir build  \
#     && cd build/  \
#     && cmake   .. \
#     && make

# RUN export GIT_COMMIT_SHA=1dffea3d917445d70d33d0c7492919fc4408fe5c \
#     && cd $HOME \
#     && git clone https://github.com/sparsehash/sparsehash.git \
#     && cd sparsehash \
#     && git checkout $GIT_COMMIT_SHA \
#     && ./configure \
#     && make install

# RUN export GIT_COMMIT_SHA=844e0648977f1fc760a3c6862fe4843d14b7cb58 \
#     && cd $HOME \
#     && git clone https://github.com/axl-bernal/CraiG.git

# # grab previous commit for some models due to symlinks used in repo
# RUN export GIT_COMMIT_SHA=e47f519fccc6a9a3674f64493afa4a830939052a \
#     && cd $HOME/CraiG/models \
#     && git checkout $GIT_COMMIT_SHA human-cons.intergenic.cimm \
#     && git checkout $GIT_COMMIT_SHA human-rna.splicesites \
#     && git checkout $GIT_COMMIT_SHA human-rna.exon.cimm \
#     && git checkout $GIT_COMMIT_SHA human-rna.intron.cimm \
#     && git checkout $GIT_COMMIT_SHA human-rna.intergenic.cimm \
#     && git checkout $GIT_COMMIT_SHA athaliana-evid.exon.cimm \
#     && git checkout $GIT_COMMIT_SHA athaliana-evid.intergenic.cimm \
#     && git checkout $GIT_COMMIT_SHA athaliana-evid.intron.cimm

# COPY ./patches/*.diff /root/CraiG/src/

# RUN cd $HOME/CraiG/src \
#      && patch aggregate_scorefilter_vals.cpp <aggregate_scorefilter_vals.cpp.diff \
#      && patch aggregate_signalfilter_vals.cpp <aggregate_signalfilter_vals.cpp.diff \
#      && patch GeneUtils.cpp <GeneUtils.cpp.diff

# RUN cd $HOME/CraiG  && \
#   ./autogen.sh  && \
#   ./configure --prefix="${PREFIX_INSTALLATION}" --enable-opt=yes --enable-mpi=no && \
#   make && make install && make installcheck
# #  if [[ -f python/requirements.txt ]]; then pip install -r python/requirements.txt; fi

env SAMTOOLS_VER=1.7
RUN cd $HOME && \
  curl -LO "https://gigenet.dl.sourceforge.net/project/samtools/samtools/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2" && \
  rm -rf "samtools-${SAMTOOLS_VER}" && \
  tar xf "samtools-${SAMTOOLS_VER}.tar.bz2" && \
  cd "samtools-${SAMTOOLS_VER}" && \
  ./configure --prefix=$HOME/samtools && \
  make && \
  make install


RUN pip install numpy>=1.13.3

