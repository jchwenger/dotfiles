pip install tensorflow

# DO NOT INSTALL nvidia-cuda-toolkit

# SEE THIS Q
# https://stackoverflow.com/questions/64629966/debug-broken-tensorflow-gpu-installation-with-conda-1-14-vs-2-3-ubuntu-18-04

# sudo apt-get install --no-install-recommends cuda-10-1
# ABOVE BROKEN ! simply do
conda install cudatoolkit=10.1.243

# (the following can be installed independently of the above)

# sudo apt-get install --no-install-recommends \
#     libcudnn7=7.6.4.38-1+cuda10.1  \
#     libcudnn7-dev=7.6.4.38-1+cuda10.1
sudo apt-get install --no-install-recommends \
    cuda-10-1 \
    libcudnn7=7.6.5.32-1+cuda10.1  \
    libcudnn7-dev=7.6.5.32-1+cuda10.1

# Install TensorRT. Requires that libcudnn7 is installed above.
# sudo apt-get install -y --no-install-recommends --allow-downgrades \
#     libnvinfer6=6.0.1-1+cuda10.1 \
#     libnvinfer-dev=6.0.1-1+cuda10.1 \
#     libnvinfer-plugin6=6.0.1-1+cuda10.1
sudo apt-get install -y --no-install-recommends \
  libnvinfer6=6.0.1-1+cuda10.1 \
  libnvinfer-dev=6.0.1-1+cuda10.1 \
  libnvinfer-plugin6=6.0.1-1+cuda10.1

sudo apt autoremove

# to prevent updating:
# https://askubuntu.com/a/18656/1092704
sudo dpkg --get-selections  |\
  grep -Ei "cuda|cudnn|cublas|libnvinfer|nvidia" |\
  cut -f 1 |\
  xargs -i sh -c "echo {} hold | sudo dpkg --set-selections"
