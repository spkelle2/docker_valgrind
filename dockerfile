FROM arm64v8/ubuntu:22.04

# set system variables needed for coin-or build
ENV COIN_INSTALL_DIR=/Users/sean/coin-or/dist
ENV LD_LIBRARY_PATH=/Users/sean/coin-or/dist/lib

# set system variables for container build
ARG PATH="/Users/sean/opt/miniconda3/bin:${PATH}"

# update and install packages for centos
RUN apt-get -y update && apt-get install -y build-essential vim valgrind wget git gfortran

# set up COIN-OR
RUN mkdir -p /Users/sean/opt/ && cd /Users/sean/ && git config --global http.postBuffer 1048576000 && git clone https://github.com/coin-or/coinbrew coin-or && cd coin-or && ./coinbrew fetch Cbc@2.10 --skip="ThirdParty/Blas ThirdParty/Lapack ThirdParty/Metis ThirdParty/Mumps" --no-prompt

# set up conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh && bash Miniconda3-latest-Linux-aarch64.sh -b -p /Users/sean/opt/miniconda3 && rm -f Miniconda3-latest-Linux-aarch64.sh

# set up CyLP
RUN conda create -n CyLP cython numpy=1.22.3 pkg-config scipy && conda init
