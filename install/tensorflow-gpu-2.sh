pip install tensorflow

# other option to be tried, instead of the below
# conda install -c anaconda cudatoolkit=10.1 cudnn=7.6.4

# Install development and runtime libraries (~4GB)
sudo apt-get install --no-install-recommends cuda-10-1
sudo apt-get install --no-install-recommends \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1

# Install TensorRT. Requires that libcudnn7 is installed above.
sudo apt-get install -y --no-install-recommends --allow-downgrades \
    libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1

sudo apt autoremove
