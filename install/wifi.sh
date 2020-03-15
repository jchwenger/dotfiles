#!/bin/bash

# wifi issues
#------------

# source: https://ubuntuforums.org/showthread.php?t=370108
echo "---------------------------"
echo "fixing wifi on Ubuntu 18.04"
cd ~

# wifi diagnosis
# https://github.com/UbuntuForums/wireless-info
echo "running some diagnoses & saving in ~/wireless-info.txt"
wget -N -t 5 -T 10 https://github.com/UbuntuForums/wireless-info/raw/master/wireless-info
chmod +x wireless-info
./wireless-info
if [ -f wireless-info.tar.gz ]; then
	tar -xvzf wireless-info.tar.gz
	rm wireless-info.tar.gz
fi

# https://askubuntu.com/a/1071334
# make sure SECURE BOOT is disabled
sudo apt install --reinstall git dkms build-essential linux-headers-$(uname -r)
git clone https://github.com/tomaspinho/rtl8821ce
cd rtl8821ce
chmod +x dkms-install.sh
chmod +x dkms-remove.sh
sudo ./dkms-install.sh
cd ~ 

# see also these pages:
# https://askubuntu.com/a/990571
# https://askubuntu.com/a/1161104
# as per: https://github.com/tomaspinho/rtl8821ce#pcie-activate-state-power-management
# also recommends to change line in 
echo "if problem persists, please update grub following the commented instructions"
# sudo vim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"
# sudo update-grub
# reboot