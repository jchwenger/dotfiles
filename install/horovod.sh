# https://github.com/horovod/horovod
# assuming CUDA 10.1

# 1 instal openmpi
cd /tmp
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.3.tar.bz2
tar -xvjf openmpi-4.0.3.tar.bz2
cd openmpi-4.0.3.tar.bz2
./configure --prefix=/usr/local
sudo make all install

# 2 install nccl
# register to the super annoying Nvidia developer program to get the links
# https://developer.nvidia.com/nvidia-developer-program
sudo dpkg -i nccl-repo-<version>.deb
sudo apt update
sudo apt install libnccl2=2.4.8-1+cuda10.1 libnccl-dev=2.4.8-1+cuda10.1

# 3 install horovod
HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL pip install horovod

# other reference
# https://lambdalabs.com/blog/horovod-keras-for-multi-gpu-training/
