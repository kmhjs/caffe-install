#! /usr/bin/env bash

#
# Prepare base system
#

# Update all repositories
sudo apt-get update

# Install base requirements
sudo apt-get install -y build-essential
sudo apt-get install -y git

# Install atlas and hdf5
sudo apt-get install -y libatlas-base-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y libyaml-dev

# Install python elements
sudo apt-get install -y python-pip
sudo apt-get install -y Cython python-numpy python-scipy

# Install other requirements
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler

#
# Install caffe
#
[[ ! -e $HOME/bin ]] && mkdir $HOME/bin
cd $HOME/bin

# Get project from github
[[ ! -e $HOME/bin/caffe ]] && git clone https://github.com/BVLC/caffe.git

# Install other python requirements
[[ -e $HOME/bin/caffe/python/requirements.txt ]] && sudo pip install -r $HOME/bin/caffe/python/requirements.txt

# Update make file
[[ -e $HOME/bin/caffe/Makefile.config ]] && cat $HOME/bin/caffe/Makefile.config.example | sed 's!# CPU_ONLY!CPU_ONLY!g' > $HOME/bin/caffe/Makefile.config

# Make and check
[[ -e $HOME/bin/caffe ]] && cd $HOME/bin/caffe
[[ -e $HOME/bin/caffe/Makefile.config ]] && make all
[[ -e $HOME/bin/caffe/Makefile.config ]] && make test
[[ -e $HOME/bin/caffe/Makefile.config ]] && make runtest
