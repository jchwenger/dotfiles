#!/bin/bash

# https://stackoverflow.com/q/4774054
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
# echo "from src: $SCRIPTPATH"

# remove intro sound
# ------------------
# hold F2 when booting > find option in BIOS (advanced settings) & turn sound off

# resolution issues
# -----------------
# source: https://medium.com/better-programming/how-i-fixed-my-display-resolution-by-installing-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux-489563052f6c
sudo apt update && sudo apt upgrade
sudo apt dist-upgrade
sudo apt install bc module-assistant build-essential dkms linux-headers-$(uname -r) -y
sudo m-a prepare

# apt keys update
# ---------------
# https://github.com/yarnpkg/yarn/issues/7866
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

# https://askubuntu.com/a/15272
# for the problem: The following signatures couldn't be verified because the
# public key is not available: NO_PUBKEY <PUBKEY>
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <PUBKEY>

# (also for google-sdk)
# https://serverfault.com/a/906973
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# check devices
# -------------
# ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

# firewall
# --------
# https://linuxconfig.org/how-to-enable-disable-firewall-on-ubuntu-18-04-bionic-beaver-linux
sudo ufw enable

# git
# ---
# https://unix.stackexchange.com/questions/33617/how-can-i-update-to-a-newer-version-of-git-using-apt-get
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt install git -y
git config --global user.name "jchwenger"
git config --global user.email "34098722+jchwenger@users.noreply.github.com"
sudo snap install hub --classic
# filter-repo
# https://github.com/newren/git-filter-repo/
cd $HOME
git clone https://github.com/newren/git-filter-repo

git config --global diff.tool gvimdiff
git config --global merge.tool gvimdiff
git config --global --add difftool.prompt false

# git cli
# -------
# https://github.com/cli/cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh

# github large files
# ------------------
# https://git-lfs.github.com/
cd /tmp && mkdir lfs && cd lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
wget https://github.com/git-lfs/git-lfs/releases/download/v2.13.2/git-lfs-linux-amd64-v2.13.2.tar.gz
tar xvzf https://github.com/git-lfs/git-lfs/releases/download/v2.13.2/git-lfs-linux-amd64-v2.13.2.tar.gz
sudo ./install.sh

# linux things, etc
# --------
# https://pandoc.org/org
# https://freedesktop.org/software/pulseaudio/pavucontrol/
# https://htop.dev/

sudo apt install \
  curl \
  rename \
  pavucontrol \
  xclip \
  tree \
  pandoc \
  htop -y

# pandoc lua filters (for docx pagebreaks)
# ----------------------------------------
# https://github.com/pandoc/lua-filters
PANDOC_DIR=/home/jcw/.local/share/pandoc
RELEASE_URL=https://github.com/pandoc/lua-filters/releases/latest
curl -LSs $RELEASE_URL/download/lua-filters.tar.gz | \
    tar --strip-components=1 --one-top-level=$PANDOC_DIR -zvxf -v

# vim
# ---
# (from source <3)
# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source
# https://askubuntu.com/a/132736
# software-properties: https://askubuntu.com/a/857433
sudo apt remove \
  vim \
  vim-runtime \
  vim-tiny \
  vim-common \
  vim-gui-common \
  vim-gnome \
  vim-gtk3 \
  vim-nox

sudo apt install \
  libncurses5-dev \
  libgnome2-dev \
  libgnomeui-dev \
  libgtk2.0-dev \
  libatk1.0-dev \
  libbonoboui2-dev \
  libcairo2-dev \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  python3-dev \
  libperl-dev -y

cd $HOME
git clone https://github.com/vim/vim
sudo apt-get build-dep vim-gnome -y
sudo apt-get install xorg-dev -y
cd vim/

# make sure anaconda is disabled !
# https://github.com/vim/vim/issues/1961
# https://github.com/gnudatalanguage/gdl/issues/752#issuecomment-628673886

make distclean # for cleaning the build when changing features
echo "----------------------------"
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --enable-perlinterp=yes \
            --enable-gui=auto \
            --enable-cscope \
            --with-x \
            --prefix=/usr/local
echo "----------------------------"
make VIMRUNTIMEDIR=/usr/local/share/vim/vim82

sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

# neovim setup
# (links to .vimrc)
# ------------
# https://github.com/neovim/neovim/wiki/Installing-Neovim
sudo snap install --beta nvim --classic
mkdir $HOME/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> $HOME/.config/nvim/init.vim
echo "let &packpath = &runtimepath" >> $HOME/.config/nvim/init.vim
echo "source $HOME/.vimrc" >> $HOME/.config/nvim/init.vim


# desktop etc
# -----------
sudo apt install gnome-tweaks gnome-tweak-tool -y

# wifi issues
# -----------
sudo ./$SCRIPTPATH/wifi.sh

# tlp battery
# -----------
sudo add-apt-repository ppa:linuxuprising/apps
sudo apt install tlp tlpui -y
sudo add-apt-repository --remove ppa:linuxuprising/apps
# # add this line to /etc/default/tlp
# DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"


# zsh and oh-my-zsh
# -----------------
./$SCRIPTPATH/zsh.sh

# anaconda
# --------
echo "---------------------------"
echo "installing anaconda"
cd /tmp
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
# compare integrity of sha with those found here:
# https://docs.anaconda.com/anaconda/install/hashes/lin-3-64/
sha256sum Anaconda3-2019.10-Linux-x86_64.sh
chmod +x Anaconda3-2019.10-Linux-x86_64.sh
./Anaconda3-2019.03-Linux-x86_64.sh
cd ~
source ~/.bashrc

# ipython automatic reload in profile
# -----------------------------------
ipython profile create
# > uncomment the line:
# c.InteractiveShellApp.exec_files = []
# > uncomment the line:
# c.InteractiveShellApp.exec_lines = []
# and add the three items in the list:
# '%load_ext autoreload',
# '%autoreload 2',
# 'print("Warning: disable autoreload in ipython_config.py to improve performance.")'


# pytorch
# -------
# https://github.com/pytorch/pytorch
# https://github.com/pytorch/text
conda install pytorch torchvision torchtext -c pytorch

# tensorflow
# ----------
# for tensorflow see separate files

# jax & trax
# ---
# https://github.com/google/jax
pip install --upgrade jax jaxlib==0.1.55+cuda110 -f https://storage.googleapis.com/jax-releases/jax_releases.html

# TODO: test the automated version
# pip install --upgrade https://storage.googleapis.com/jax-releases/`nvidia-smi | sed -En "s/.* CUDA Version: ([0-9]*)\.([0-9]*).*/cuda\1\2/p"`/jaxlib-0.1.45-`python3 -V | sed -En "s/Python ([0-9]*)\.([0-9]*).*/cp\1\2/p"`-none-linux_x86_64.whl jax

# TODO: build from source
# https://jax.readthedocs.io/en/latest/developer.html#building-from-source

mkdir $HOME/dl
git clone https://github.com/google/jax $HOME/dl/jax
git clone https://github.com/google/trax $HOME/dl/trax

# other dl things
git clone https://github.com/huggingface/transformers.git $HOME/dl/transformers
cd $HOME/dl/transformers
pip install .

# NLP
# ----
# https://www.nltk.org/
# https://spacy.io/
# https://radimrehurek.com/gensim/
# https://github.com/Helsinki-NLP/OpusTools
# https://github.com/LuminosoInsight/python-ftfy
pip install --upgrade \
  nltk \
  spacy \
  gensim \
  opustools \
  ftfy

# CMAKE (also needed for the below)
# ---------------------------------
# https://stackoverflow.com/a/56690743
wget -qO - https://apt.kitware.com/keys/kitware-archive-latest.asc |
    sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt-get update
sudo apt-get install cmake

# Updating GCC (8 & 7 together)
# -----------------------------
# https://stackoverflow.com/a/65284832
# https://askubuntu.com/a/1028656
sudo apt-get install g++-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# MOA NLP
# -------
mkdir $HOME/dl/encoding
cd $HOME/dl/encoding

# https://github.com/rsennrich/subword-nmt
git clone https://github.com/rsennrich/subword-nmt

# https://github.com/glample/fastBPE
git clone https://github.com/glample/fastBPE
cd fastBPE
g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
cd ..

# https://github.com/google/sentencepiece
pip install sentencepiece
git clone https://github.com/google/sentencepiece
cd sentencepiece

# install from source
sudo apt-get install \
  build-essential \
  pkg-config \
  libgoogle-perftools-dev

mkdir build
cd build
cmake ..
make -j $(nproc)
sudo make install
sudo ldconfig -v
cd $HOME

# python web &c
# -------------
# starlette          https://www.starlette.io/
# uvicorn            https://www.uvicorn.org/
# aiofiles           https://pypi.org/project/aiofiles/
# Jinja2             https://jinja.palletsprojects.com/en/2.11.x/
# ujson              https://pypi.org/project/ujson/
# requests           https://pypi.org/project/requests/
# tqdm               https://github.com/tqdm/tqdm
# fire (cli)         https://github.com/google/python-fire
# toposort           https://pypi.org/project/toposort/
# black (formatting) https://pypi.org/project/black/
# flask              https://flask.palletsprojects.com/en/1.1.x/
# websocket-client   https://github.com/websocket-client/websocket-client
# python-socketio    https://python-socketio.readthedocs.io/en/latest/

pip install \
  starlette \
  uvicorn \
  aiofiles \
  Jinja2 \
  ujson \
  requests

conda install -c anaconda \
  flask \
  -y

conda install -c conda-forge \
  flask-socketio \
  websocket-client \
  python-socketio \
  tqdm \
  fire \
  toposort \
  black \
  -y

# pdf to text utility
# -------------------
# https://github.com/euske/pdfminer
conda install -c conda-forge pdfminer -y

# openFrameworks
# --------------
# get db of compiling flags in c/c++
# usage: compiledb make
# -> generates a json file that YouCompleteMe (Vim) can read
# in future, test this: https://github.com/rdnetto/YCM-Generator
pip install compiledb
# config for vim & YouCompleteMe there:
# https://gist.github.com/daragao/70ed63ee8992c401a9dd#file-gistfile1-pytb
# (copy to ~/.vim/.ycm_extra_conf_openframeworks.py", then update .vimrc to contain:
# let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf_openframeworks.py"

# Processing
# ----------
# https://processing.org
cd ~
wget https://github.com/processing/processing4/releases/download/processing-1282-4.0b7/processing-4.0b7-linux-x64.tgz
tar xvzf processing-4.0b7-linux-x64.tgz
rm processing-4.0b7-linux-x64.tgz
cd processing-4.0b7
./install.sh

# fix slow boot
# -------------
# # https://askubuntu.com/questions/1030867/how-to-diagnose-fix-very-slow-boot-on-ubuntu-18-04
# # modify /etc/default/grub and add
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noresume"
# # alternatively: https://ubuntuforums.org/showthread.php?t=2420199
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nouveau.modeset=0 tpm_tis.interrupts=0 acpi_osi=Linux i915.preliminary_hw_support=1 idle=nomwait"
# # then:
# sudo update-grub

# set-up Fn keys
# --------------
# (DO NOT SET OPTION "aspi_osi=" to the grub, computer won't boot after that.)
# https://askubuntu.com/a/1075383
# # open and change file
# sudo vim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor"
# sudo update-grub && reboot
# # after that:
# ls -1 /sys/class/backlight/
# # should give you amdgpu_bl0
# # set with
# sudo modprobe amdgpu_bl0

# fzf
# ---
# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf
~/.fzf/install

# bat
# ---
# https://github.com/sharkdp/bat
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz
tar -xvzf bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz
rm bat-v0.12.1-x86_64-unknown-linux-gnu.tar.gz

# fd
# --
# https://github.com/sharkdp/fd
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz
tar -xvzf fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz
rm fd-v7.4.0-x86_64-unknown-linux-gnu.tar.gz

# ranger
# ------
# https://github.com/ranger/ranger
git clone https://github.com/ranger/ranger

# tmux
# ----
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
# ---------
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
# ---------
# sudo apt install dconf-cli -y
# git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git
# cd gnome-terminal-colors-solarized
# ./install.sh
# cd ~

# fonts
# -----
sudo apt install ttf-mscorefonts-installer
sudo apt install -y fonts-inconsolata
sudo fc-cache -f -v

# google cloud
# ------------
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# aws cli
# -------
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# docker
# ------
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
# grant permissions
sudo usermod -a -G docker $USER

# nvidia-docker
# -------------
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
# this command can also be reapplied when getting errors on sudo apt-get update
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
# sudo apt-get install -y nvidia-container-toolkit
rudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# latex, lyx (latex live editor)
# -----
# https://dzone.com/articles/installing-latex-ubuntu
# https://wiki.lyx.org/LyX/LyXOnUbuntu

sudo apt update
sudo add-apt-repository ppa:lyx-devel/release
sudo apt install \
  texlive-full \
  lyx

# tor
# ---
# https://www.torproject.org/download/
# check for latest version
echo "---------------------------------------------------------------"
echo "installing tor, please check that the version is the latest one"
echo "by visiting the website: https://www.torproject.org/download/"
wget https://www.torproject.org/dist/torbrowser/9.0.6/tor-browser-linux64-9.0.6_en-US.tar.xz
tor -xf tor-browser-linux64-9.0.6_en-US.tar.xz
rm tor-browser-linux64-9.0.6_en-US.tar.xz

# node / nvm
# ----------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh
source ~/.zshrc
nvm install node
nvm install-latest-npm

npm install -g http-server

# dotfiles
# --------
git clone https://github.com/jchwenger/dotfiles
# ./dotfiles/install/install.sh

# video codecs, fonts...
# ----------------------
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

# ctags
# -----
sudo snap install universal-ctags

# Zotero
# ------
# https://askubuntu.com/a/1160369
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
sudo apt update
sudo apt install zotero
# add symlink so it appears in the Ubuntu GUI
ln -s /usr/share/applications/zotero.desktop zotero.desktop
# also add Zotero Connector for Firefox from the above download page

# https://github.com/retorquere/zotero-deb/issues/52#issuecomment-1013824798
# apt error solved by running this:
wget -qO- https://apt.retorque.re/file/zotero-apt/install.sh | sudo bash

# rclone
# ------
# https://rclone.org/
curl https://rclone.org/install.sh | sudo zsh

# if still a bug with access rights for ~/.config/rclone
# sudo chown -R $USER $HOME/.config/rclone

# ripgrep
# -------
# https://github.com/BurntSushi/ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/12.0.1/ripgrep_12.0.1_amd64.deb
sudo dpkg -i ripgrep_12.0.1_amd64.deb

# jq (JSON cli-processor)
# -----------------------
# https://stedolan.github.io/jq/
sudo apt-get install jq

# Rust
# ----
# https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Teleconsole
# -----------
# https://github.com/gravitational/teleconsole
curl https://www.teleconsole.com/get.sh | sh

# ssh server
# ----------
# https://unix.stackexchange.com/a/520346
sudo apt-get install openssh-server -y
sudo systemctl start ssh

# markdown-viewer
# --------------------------
# read markdown with Firefox (install from the browser
# https://github.com/KeithLRobertson/markdown-viewer
# install for Linux:
# https://github.com/KeithLRobertson/markdown-viewer#installing-on-linux
mkdir -p $HOME/.local/share/mime/packages
f="$HOME/.local/share/mime/packages/text-markdown.xml"
touch $f
echo '<?xml version="1.0"?>' >> $f
echo '<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">' >> $f
echo '  <mime-type type="text/plain">' >> $f
echo '    <glob pattern="*.md"/>' >> $f
echo '    <glob pattern="*.mkd"/>' >> $f
echo '    <glob pattern="*.mkdn"/>' >> $f
echo '    <glob pattern="*.mdwn"/>' >> $f
echo '    <glob pattern="*.mdown"/>' >> $f
echo '    <glob pattern="*.markdown"/>' >> $f
echo '  </mime-type>' >> $f
echo '</mime-info>' >> $f
update-mime-database ~/.local/share/mime

# android sdk
# -----------
# https://stackoverflow.com/a/34627928
sudo apt update && sudo apt install android-sdk

# to backup the current state of a device:
# https://stackoverflow.com/a/42638750/9638108
# adb backup -apk -shared -all -f "$(date +'%Y-%m-%d')-backup.adb"

# sdkmanager
# ----------
# download, extract & add to the path manually
# https://developer.android.com/studio#command-tools

# just in case: change java version (here e.g. add java 8)
# --------------------------------------------------------
sudo apt-get install openjdk-8-jre
sudo update-alternatives --config java

# kvm
# ---
# check & enable virtualisation
# https://developer.android.com/studio/run/emulator-acceleration#vm-linux
sudo apt-get update
sudo apt-get install \
  cpu-checker \
  qemu \
  qemu-kvm \
  libvirt-bin  \
  bridge-utils  \
  virt-manager

# to use:
# sudo service libvirtd start
# sudo update-rc.d libvirtd enable
# service libvirtd status
# virsh net-list

# to restart
# virsh net-start default

# to stop & remove
# https://docs.openstack.org/ocata/networking-guide/misc-libvirt.html
# virsh net-destroy default
# virsh net-autostart --network default --disable
# virsh net-undefine default
# https://www.thegeekdiary.com/centos-rhel-67-how-to-disable-or-delete-virbr0-interface/
# update-rc.d libvirtd remove
# sudo systemctl disable libvirt-guests
# sudo systemctl stop libvirtd
# sudo systemctl disable libvirtd

# to remove, same as install, except with `remove --purge`
# other bridge links:
# https://unix.stackexchange.com/questions/62751/cannot-delete-bridge-bridge-br0-is-still-up-cant-delete-it
# https://askubuntu.com/questions/246343/what-is-the-virbr0-interface-used-for
# also:
# https://askubuntu.com/a/978498/1092704

# Ruby
# ----
# rvm manager: http://rvm.io/
# gpg not gpg2 for ubuntu 18, cf. http://manpages.ubuntu.com/manpages/bionic/man1/gpg2.1.html
gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# Gems
# ----
# https://rubygems.org/pages/download
sudo gem update --system

# # if 'Nothing to update' appears, do this
# gem install rubygems-update  # again, might need to be admin/root
# update_rubygems              # ... here too

# Jekyll
# ------
# https://jekyllrb.com
sudo apt-get install ruby ruby-dev-full build-essential zlib1g-dev
gem install jekyll bundler

# Gatsby
# ------
# https://www.gatsbyjs.org/
npm install -g gatsby-cli

# Yarn
# ----
# https://classic.yarnpkg.com/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn

# reboot issues
# -------------
# apport?
# https://ubuntuforums.org/showthread.php?t=1745793&page=2&p=10984235#post10984235

# debug shell on reboot
# https://askubuntu.com/q/808435/1092704
# sudo systemctl enable debug-shell
# sudo halt, then do:
# systemctl list-jobs

# mongodb
# -------
# https://www.mongodb.com/
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
# in case of an error, do this:
# sudo apt-get install gnupg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# heroku
# ------
# https://devcenter.heroku.com/articles/heroku-cli
sudo snap install --classic heroku

# forticlient vpn
# ---------------
# https://www.forticlient.com/downloads

# nordvpn
# -------
# https://nordvpn.com/download/linux/
cd ~
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo apt-get update
sudo apt-get install nordvpn-release_1.0.0_all.deb
sudo apt-get install nordvpn
rm nordvpn-release_1.0.0_all.deb

# js-beautify
# -----------
# https://www.npmjs.com/package/js-beautify

npm -g install js-beautify

# caps & other locks indicator
# ----------------------------
# https://www.howtogeek.com/274587/how-to-get-a-notification-when-caps-lock-or-num-lock-is-enabled-in-ubuntu/
sudo add-apt-repository ppa:tsbarnes/indicator-keylock
sudo apt-get update
sudo apt install indicator-keylock

# bluetooth
# ---------
# https://askubuntu.com/questions/1051640/bluetooth-bluez-and-blueman-applet-xubuntu-18-04
gsettings set org.blueman.plugins.powermanager auto-power-on false

# safari (thru wine & playonlinux)
# ------
# after some hell, just used the software manager

# remove apt-key, apt-ad-repository
# ---------------------------------
# https://askubuntu.com/questions/107177/how-can-i-remove-gpg-key-that-i-added-using-apt-key-add
# sudo apt-key list
# the last two groups of the public key together form the id, ex:

# /etc/apt/trusted.gpg.d/wireshark-dev_ubuntu_stable.gpg
# ------------------------------------------------------
# pub   rsa4096 2014-12-12 [SC]
#       A2E4 02B8 5A4B 70CD 78D8  A3D9 D875 5513 14EC A0F0
# uid           [ unknown] Launchpad PPA for Wireshark Developers

# -->
# sudo apt-key del 14ECA0F0

# https://itsfoss.com/how-to-remove-or-delete-ppas-quick-tip/

# sudo add-apt-repository --remove ppa:PPA_Name/ppa

# sudo ls /etc/apt/sources.list.d
# sudo rm -i /etc/apt/sources.list.d/PPA_Name.list

# purge:
# sudo apt-get install ppa-purge
# sudo ppa-purge ppa-url

# aria2 download utility
# https://aria2.github.io/
sudo apt update && sudo apt install aria2

# httrack website copier
# http://www.httrack.com/
sudo apt update && sudo apt install webhttrack

# remove Imagemagick policy restrictions
# https://askubuntu.com/a/1081907
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout
# to reverse:
# sudo mv /etc/ImageMagick-6/policy.xmlout /etc/ImageMagick-6/policy.xml

# tesseract pdf
# -------------
# https://github.com/tesseract-ocr/tesseract
sudo apt-get install tesseract-ocr
sudo apt-get install tesseract-ocr-fra

# webp tool
# ---------
# https://developers.google.com/speed/webp
sudo apt install webp

# openconnect
# ----------
sudo add-apt-repository ppa:phusen/openconnect

# peek (gif from screen)
# ----------------------
# https://askubuntu.com/a/833995
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek

# runiq (fast deduplication, in Rust)
# -------------------------
# https://github.com/whitfin/runiq
cargo install runiq

# pigz (parallel gzip)
# --------------------
# https://zlib.net/pigz/
# (download, untar & make manually)

# hck (rougher form of cut)
# -------------------------
# https://github.com/sstadick/hck
# (update rust if needed: https://www.rust-lang.org/tools/install)
export RUSTFLAGS='-C target-cpu=native'
cargo install hck

# jpegoptim
# ---------
# https://www.kokkonen.net/tjko/src/man/jpegoptim.txt
# https://github.com/tjko/jpegoptim
sudo apt-get install jpegoptim

# youtube-dl
# ----------
# https://github.com/ytdl-org/youtube-dl
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# screenkey
# ---------
# https://gitlab.com/screenkey/screenkey
# thru ubuntu installer
# app indicator:
sudo apt-get install gir1.2-appindicator3-0.1

# redis db
# --------
# https://redis.io/topics/quickstart
cd ~
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
# configure
sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo cp utils/redis_init_script /etc/init.d/redis_6379
# sudo vi /etc/init.d/redis_6379 # optionally change port
# ! POTENTIAL BUG !
# add these two lines after # Provides: redis_6379
# # Required-Start:    $network $remote_fs $local_fs
# # Required-Stop:     $network $remote_fs $local_fs
# cf: https://stackoverflow.com/a/40234057
sudo cp redis.conf /etc/redis/6379.conf
sudo mkdir /var/redis/6379
# ---
# edit the file:
# sudo vim /etc/redis/6379.conf
# daemonize yes
# pidfile change fname if port is different
# loglevel change if wished
# logfile "/var/log/redis_6379.log"
# ! IMPORTANT:
# dir /var/redis/6379
# ---
sudo update-rc.d redis_6379 defaults
sudo /etc/init.d/redis_6379 start

# Gnome Sushi
-------------
# MacOS-style preview for Nautilus
# apt install thru the website:
# https://help.ubuntu.com/stable/ubuntu-help/files-preview.html.en
# https://gitlab.gnome.org/GNOME/sushi
# then for LibreOffice compatibility
# https://manpages.ubuntu.com/manpages/bionic/man1/doc2odt.1.html
sudo apt update
sudo apt install unoconv

# libreoffice
# -----------
# https://blog.programster.org/ubuntu-18-04-install-libreoffice-from-ppa
sudo add-apt-repository ppa:libreoffice/ppa -y \
  && sudo apt update \
  && sudo apt install libreoffice -y

# conky
# -----
sudo apt-get install conky
# config: https://github.com/ernesto1/monochrome

# ocproxy
# -------
# https://github.com/cernekee/ocproxy
sudo apt install ocproxy

# ffmpeg
# ------
sudo apt remove --purge ffmpeg
sudo snap install ffmpeg
# update lib
# https://askubuntu.com/a/1340076
sudo apt update
sudo apt install libdrm-common

# # thermald
# # --------
# # https://github.com/intel/thermal_daemon
# # dependencies
# sudo apt-get install autoconf
# sudo apt-get install autoconf-archive
# sudo apt-get install g++
# sudo apt-get install libglib2.0-dev
# sudo apt-get install libdbus-1-dev
# sudo apt-get install libdbus-glib-1-dev
# sudo apt-get install libxml2-dev
# sudo apt-get install gtk-doc-tools
# sudo apt-get install libupower-glib-dev
# sudo apt-get install liblzma-dev
# sudo apt-get install libevdev-dev
# cd ~
# git clone https://github.com/intel/thermal_daemon
# cd thermal_daemon
# ./autogen.sh prefix=/
# make
# sudo make install

# cpufrequtils
# ------------
# https://askubuntu.com/a/936488
sudo apt-get install cpufrequtils
# https://askubuntu.com/a/1049313
sudo systemctl disable ondemand
# create file
# sudo vim /etc/default/cpufrequtils
# GOVERNOR="performance" or
# GOVERNOR="powersave"

# entr (any action if file changes)
# ---------------------------------
# https://github.com/eradman/entr
# https://eradman.com/entrproject/
cd
git clone https://github.com/eradman/entr
cd entr
./configure
make test
sudo make install

# libtorrent (for deluge)
# -----------------------
sudo apt update
sudo apt install python-libtorrent

# cairo & pycairo (vector graphics)
# ---------------------------------
sudo apt install libcairo2-dev pkg-config
conda install pycairo

# keyman IPA keyboard
# -------------------
# https://help.keyman.com/products/linux/current-version/common/
sudo add-apt-repository ppa:keymanapp/keyman
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install keyman onboard-keyman

# cmus
# ----
# https://manpages.ubuntu.com/manpages/bionic/man7/cmus-tutorial.7.html
sudo apt-get update
sudo apt-get install cmus
