# in case there are conflicting versions of nvidia & cuda drivers

# https://askubuntu.com/a/530050/1092704
# https://askubuntu.com/a/530050
sudo apt-get purge --auto-remove nvidia-cuda-toolkit -y

# https://askubuntu.com/a/1077063
# sudo rm /etc/apt/sources.list.d/cuda*

# https://github.com/tensorflow/tensorflow/issues/43236#issuecomment-693244342
# To start fresh, clean up all the nivida-related packages. Be careful when using the same system as a desktop!
sudo apt-get --purge remove 'cuda*'
sudo apt-get --purge remove 'nvidia*'
sudo apt-get --purge remove 'libnvidia*'
sudo apt-get --purge remove 'libcudnn*'
sudo apt-get --purge remove 'libnccl*'
sudo apt-get --purge remove 'nccl*'

# Check if all clean
# sudo find /usr/local/cuda/ -name '*blas*'
# sudo find /usr/lib/ -name '*blas*'

# https://askubuntu.com/a/1180417
# sudo apt-get --purge -y remove 'cuda*' 'nvidia*'

sudo reboot

# fix divergences:
# https://askubuntu.com/a/1041703
LC_MESSAGES=C dpkg-divert --list '*nvidia-340*' | sed -nre 's/^diversion of (.*) to .*/\1/p' | xargs -rd'\n' -n1 -- sudo dpkg-divert --remove
sudo apt --fix-broken install
