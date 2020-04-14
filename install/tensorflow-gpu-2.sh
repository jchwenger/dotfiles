pip install tensorflow

# Install development and runtime libraries (~4GB)
sudo apt-get install --no-install-recommends \
    cuda-10-1 \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1

# Install TensorRT. Requires that libcudnn7 is installed above.
sudo apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1

sudo apt autoremove

# Install TensorRT. Requires that libcudnn7 is installed above.
# # other attempts before finding the tf commands
# # installing CUDA and cuDNN
# # https://developer.nvidia.com/cuda-downloads/
# echo "---------------------------"
# echo "installing CUDA & cuDNN"
# cd /tmp
# wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
# sudo sh cuda_10.2.89_440.33.01_linux.run
# cd ~
# # then go and download the cuDNN library there (after login):
# # https://developer.nvidia.com/rdp/cudnn-download
# # and install it:
# sudo dpkg -i /home/$(whoami)/Downloads/libcudnn7-dev_7.6.5.32-1+cuda10.2_amd64.deb

# # a simple procedure with this
# # https://askubuntu.com/a/1036265
# sudo add-apt-repository ppa:graphics-drivers/ppa
# sudo apt update
# sudo ubuntu-drivers autoinstall
# sudo apt install nvidia-cuda-toolkit gcc-6
# # then nvcc --version

# # other source:
# # https://medium.com/@shravan007.c/tensorflow-2-1-running-on-gpu-ubuntu-18-04-76b0c8b0a25d
# sudo dpkg -i nv-tensorrt-repo-ubuntu1804-cuda10.1-trt6.0.1.5-ga-20190913_1-1_amd64.deb
# sudo apt-key add /var/nv-tensorrt-repo-cuda10.1-trt6.0.1.5-ga-20190913/7fa2af80.pub
# sudo apt-get update
# sudo apt-get install tensorrt
