# in case there are conflicting versions of nvidia & cuda drivers

# https://askubuntu.com/a/530050
sudo apt-get remove --auto-remove nvidia-cuda-toolkit -y

# https://askubuntu.com/a/1077063
sudo rm /etc/apt/sources.list.d/cuda*

# https://askubuntu.com/a/1180417
sudo apt-get --purge -y remove 'cuda*' 'nvidia*'
sudo reboot

# fix divergences:
# https://askubuntu.com/a/1041703
LC_MESSAGES=C dpkg-divert --list '*nvidia-340*' | sed -nre 's/^diversion of (.*) to .*/\1/p' | xargs -rd'\n' -n1 -- sudo dpkg-divert --remove
sudo apt --fix-broken install
