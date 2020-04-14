# in case there are conflicting versions of nvidia & cuda drivers

# https://askubuntu.com/a/530050
sudo apt-get remove --auto-remove nvidia-cuda-toolkit

# https://askubuntu.com/a/1180417
sudo apt-get --purge -y remove 'cuda*'
sudo apt-get --purge -y remove 'nvidia*'
sudo reboot
