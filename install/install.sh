#!/bin/bash

# https://stackoverflow.com/q/4774054
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
# echo "from src: $SCRIPTPATH"

# remove intro sound
#-------------------
# hold F2 when booting > find option in BIOS (advanced settings) & turn sound off

# resolution issues
#------------------
# source: https://medium.com/better-programming/how-i-fixed-my-display-resolution-by-installing-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux-489563052f6c
sudo apt update && sudo apt upgrade
sudo apt dist-upgrade
sudo apt install bc module-assistant build-essential dkms linux-headers-$(uname -r) -y
sudo m-a prepare

# check devices
#--------------
# ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

# git
#----
sudo apt install git -y
git config --global user.name "jchwenger"
git config --global user.email "34098722+jchwenger@users.noreply.github.com"
sudo snap install hub --classic

# vim, etc
#---------
sudo apt install \
  vim-gnome \
  neovim \
  curl \
  rename \
  pavucontrol \
  xclip -y

# desktop etc
#------------
sudo apt install gnome-tweaks gnome-tweak-tool -y

# wifi issues
#------------
source $SCRIPTPATH/wifi.sh

# fix patchy wifi by editing the file
# https://askubuntu.com/a/1077559
# /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
# from wifi.powersave = 3 to 2

# other potential fix: restart NetworkManager
# https://askubuntu.com/questions/253257/ubuntu-doesnt-reconnect-to-wifi-unless-i-reboot
# sudo service network-manager restart

# # tried to install the older driver
# # https://packages.ubuntu.com/bionic-updates/rtl8821ce-dkms
# sudo apt install rtl8821ce-dkms -y

# which did not work, using instead a repository, as described here:
# https://askubuntu.com/a/1071336
git clone https://github.com/tomaspinho/rtl8821ce
cd rtl8821ce
sudo ./dkms-install.sh
cd ~

# tlp battery
#------------
sudo add-apt-repository ppa:linuxuprising/apps
sudo apt install tlp tlpui -y
sudo add-apt-repository --remove ppa:linuxuprising/apps

# zsh and oh-my-zsh
#------------------
# https://github.com/ohmyzsh/ohmyzsh
echo "---------------------------"
echo "installing zsh & oh-my-zsh"
sudo apt install zsh -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# anaconda
#---------
echo "---------------------------"
echo "installing anaconda"
cd /tmp
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
# compare integrity of sha with those found here:
# https://docs.anaconda.com/anaconda/install/hashes/lin-3-64/
sha256sum Anaconda3-2019.03-Linux-x86_64.sh
chmod +x Anaconda3-2019.03-Linux-x86_64.sh
./Anaconda3-2019.03-Linux-x86_64.sh
cd ~
source ~/.bashrc

# pytorch
#--------
# https://github.com/pytorch/pytorch
# https://github.com/pytorch/text
conda install \
	pytorch \
	torchtext \

# tensorflow
#-----------
# for tensorflow see separate files

# jax
#----
# https://github.com/google/jax
PYTHON_VERSION=cp37  # alternatives: cp35, cp36, cp37, cp38
CUDA_VERSION=cuda102  # alternatives: cuda92, cuda100, cuda101, cuda102
PLATFORM=linux_x86_64  # alternatives: linux_x86_64
BASE_URL='https://storage.googleapis.com/jax-releases'
pip install --upgrade $BASE_URL/$CUDA_VERSION/jaxlib-0.1.40-$PYTHON_VERSION-none-$PLATFORM.whl
pip install --upgrade jax  # install jax

git clone https://github.com/google/jax ~/dl/jax
git clone https://github.com/google/trax ~/dl/trax

# other dl things
mkdir ~/dl
git clone https://github.com/huggingface/transformers.git ~/dl/transformers
cd ~/dl/transformers
pip install .

# NLP
#-----
# https://www.nltk.org/
# https://spacy.io/
# https://radimrehurek.com/gensim/
pip install --upgrade \
	nltk \
	spacy \
	gensim

# fix slow boot
#--------------
# https://askubuntu.com/questions/1030867/how-to-diagnose-fix-very-slow-boot-on-ubuntu-18-04
# modify /etc/default/grub and add
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noresume", then
# sudo update-grub

# fzf
#----
# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf
~/.fzf/install

# bat
#----
# https://github.com/sharkdp/bat
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz
tar -xvzf bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz
rm bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz

# fd
#---
# https://github.com/sharkdp/fd
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz
tar -xvzf fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz
rm fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz

# ranger
#-------
# https://github.com/ranger/ranger
git clone https://github.com/ranger/ranger

# tmux
#-----
# https://github.com/tmux/tmux
sudo apt-get install \
  autotools-dev \
  automake \
  libevent-dev \
  libncurses5-dev \
  libncursesw5-dev \
  byacc -y

# sudo apt install tmux -y
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
cd ~

# powerline
#----------
# https://askubuntu.com/a/283909
pip install powerline-status
sudo apt-get install fonts-powerline

# # this fix used, but will be integrated into a future version:
# # https://github.com/powerline/powerline/pull/2033#issuecomment-596020388
# git clone https://github.com/powerline/powerline && \
# cd powerline && \
# git checkout develop && \
# pip install ./  # use --user flag if desired

# wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
# mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
# fc-cache -vf ~/.fonts
# mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# solarized
#----------
# sudo apt install dconf-cli -y
# git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git
# cd gnome-terminal-colors-solarized
# ./install.sh
# cd ~

# fonts
#------
sudo apt install ttf-mscorefonts-installer
sudo fc-cache -f -v

# google cloud
#-------------
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# docker
#-------
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "----------------------"
echo "Verify that you now have the key with the fingerprint"
echo "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
sudo apt-key fingerprint 0EBFCD88
echo "----------------------"
 sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install \
	docker-ce \
	docker-ce-cli \
	containerd.io

# latex, lyx (latex live editor)
#------
# https://dzone.com/articles/installing-latex-ubuntu
# https://wiki.lyx.org/LyX/LyXOnUbuntu

sudo apt update
sudo add-apt-repository ppa:lyx-devel/release
sudo apt install \
	texlive-full \
	lyx

# tor
#----
# https://www.torproject.org/download/
# check for latest version 
echo "---------------------------------------------------------------"
echo "installing tor, please check that the version is the latest one"
echo "by visiting the website: https://www.torproject.org/download/"
wget https://www.torproject.org/dist/torbrowser/9.0.6/tor-browser-linux64-9.0.6_en-US.tar.xz
tor -xf tor-browser-linux64-9.0.6_en-US.tar.xz
rm tor-browser-linux64-9.0.6_en-US.tar.xz

# node / nvm
#-----------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh
source ~/.zshrc
nvm install node
nvm install-latest-npm

# dotfiles
#---------
git clone https://github.com/jchwenger/dotfiles
# ./dotfiles/install/install.sh

# video codecs, fonts...
#-----------------------
# https://tor.stackexchange.com/a/19274
sudo apt update
sudo apt install \
	libdvdnav4 \
	libdvdread4 \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg
sudo apt install ubuntu-restricted-extras
