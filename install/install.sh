#!/bin/bash

# https://stackoverflow.com/q/4774054
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
# echo "from src: $SCRIPTPATH"

# git
# ---
# https://unix.stackexchange.com/questions/33617/how-can-i-update-to-a-newer-version-of-git-using-apt-get
git config --global user.name "jchwenger"
git config --global user.email "34098722+jchwenger@users.noreply.github.com"
sudo snap install hub --classic

git config --global diff.tool nvimdiff
git config --global merge.tool nvimdiff
git config --global --add difftool.prompt false

# https://claude.ai/share/02804a1b-f9d6-4690-8173-f55330065392
git config --global diff.docx.textconv "pandoc --from=docx --to=markdown --wrap=none"
git config --global diff.odt.textconv  "pandoc --from=odt --to=markdown --wrap=none"

# Cache conversions so repeated diffs/logs stay fast
git config --global diff.docx.cachetextconv true
git config --global diff.odt.cachetextconv true

mkdir -p ~/.config/git
touch ~/.config/git/attributes
echo '*.docx diff=docx' >> ~/.config/git/attributes
echo '*.odt  diff=odt' >> ~/.config/git/attributes
echo '*.doc  diff=doc' >> ~/.config/git/attributes

git config --global diff.wordDiff true


# pandoc lua filters (for docx pagebreaks)
# ----------------------------------------
# https://github.com/pandoc/lua-filters
PANDOC_DIR=/home/jcw/.local/share/pandoc
RELEASE_URL=https://github.com/pandoc/lua-filters/releases/latest
mkdir -p $PANDOC_DIR; cd $PANDOC_DIR
wget $RELEASE_URL/download/lua-filters.tar.gz
tar --strip-components=1 -zvxf lua-filters.tar.gz
rm lua-filters.tar.gz
cd -

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

# zsh and oh-my-zsh
# -----------------
./$SCRIPTPATH/zsh.sh

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


# fzf
# ---
# https://github.com/junegunn/fzf
brew install fzf

# bat
# ---
# https://github.com/sharkdp/bat
brew install bat

# # ranger
# # ------
# # https://github.com/ranger/ranger
# git clone https://github.com/ranger/ranger

# powerline
# ---------
python3 -m pip install powerline-status

# solarized
# ---------
# sudo apt install dconf-cli -y
# git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git
# cd gnome-terminal-colors-solarized
# ./install.sh
# cd ~

# google cloud
# ------------
# https://formulae.brew.sh/cask/google-cloud-sdk
brew install --cask google-cloud-sdk

# aws cli
# -------
# https://formulae.brew.sh/formula/awscli
brew install awscli

# docker
# ------
# https://formulae.brew.sh/formula/docker
brew install docker

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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | zsh
source ~/.zshrc
nvm install --lts
nvm use --lts

npm install -g http-server

# dotfiles
# --------
git clone https://github.com/jchwenger/dotfiles
# ./dotfiles/install/install.sh


# rclone
# ------
# https://rclone.org/
curl https://rclone.org/install.sh | sudo zsh

# if still a bug with access rights for ~/.config/rclone
# sudo chown -R $USER $HOME/.config/rclone

# Rust
# ----
# https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src rustfmt-preview rust-analysis

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
# https://stackoverflow.com/questions/31374085/installing-adb-on-macos
brew install android-platform-tools

# to backup the current state of a device:
# https://stackoverflow.com/a/42638750/9638108
# adb backup -apk -shared -all -f "$(date +'%Y-%m-%d')-backup.adb"

# Ruby
# ----
# https://jekyllrb.com/docs/installation/macos/
brew install chruby ruby-install xz
ruby-install ruby 3.1.3

# Jekyll
# ------
# https://jekyllrb.com/docs/installation/macos/
gem install jekyll

# Gatsby
# ------
# https://www.gatsbyjs.org/
npm install -g gatsby-cli

# Hugo
# ----
# https://gohugo.io/installation/macos/#package-managers
brew install hugo

# Yarn
# ----
# https://classic.yarnpkg.com/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn

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

# httrack website copier
# http://www.httrack.com/
sudo apt update && sudo apt install webhttrack

# remove Imagemagick policy restrictions
# https://askubuntu.com/a/1081907
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout
# to reverse:
# sudo mv /etc/ImageMagick-6/policy.xmlout /etc/ImageMagick-6/policy.xml

# awr photo format
# ----------------
# https://stackoverflow.com/a/31258885
# https://askubuntu.com/a/526773
sudo add-apt-repository ppa:crass/ufraw
sudo apt-get update
sudo apt-get install ufraw ufraw-batch gimp-ufraw

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

# libtorrent (for deluge)
# -----------------------
sudo apt update
sudo apt install python-libtorrent

# cairo & pycairo (vector graphics)
# ---------------------------------
sudo apt install libcairo2-dev pkg-config
conda install pycairo

# cue/flac splitting
# ------------------
# https://danilodellaquila.com/en/blog/how-to-split-an-audio-flac-file-using-ubuntu-linux
sudo apt-get install cuetools shntool flac
cuebreakpoints file.cue | shnsplit -o flac file.flac

# transmission-cli
# ----------------
# https://help.ubuntu.com/community/TransmissionHowTo
# https://askubuntu.com/questions/602563/preventing-transmission-daemon-from-auto-start
sudo add-apt-repository ppa:transmissionbt/ppa
sudo apt update
sudo apt-get install transmission-cli transmission-common transmission-daemon

# inkscape (vector graphics)
# --------------------------
# https://snapcraft.io/inkscape
# however, bc of a snap issue, back to apt: https://askubuntu.com/a/1426937
# https://inkscape.org/release/inkscape-1.2.2/gnulinux/ubuntu/ppa/dl/
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape

# rsvg-convert
# ------------
# https://manpages.ubuntu.com/manpages/focal/man1/rsvg-convert.1.html
sudo apt-get install librsvg2-bin

# clang
# -----
# https://formulae.brew.sh/formula/llvm
brew install llvm

# qbittorrent
# -----------
#  https://www.qbittorrent.org/download
# chmod u+x ...AppImage
# ./..AppImage

# xdotools
# --------
# https://askubuntu.com/a/931695
sudo apt install xdotool

# go
# --
# https://go.dev/doc/install
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
# and update the PATH
# export PATH=$PATH:/usr/local/go/bin

# selenium (webdriver): installing Firefox & Chrome drivers
# ---------------------------------------------------------

# chromedriver
# https://formulae.brew.sh/cask/chromedriver
# MacOS unquarantine required: https://stackoverflow.com/a/60374958
# brew install --cask chromedriver

# geckodriver
# https://formulae.brew.sh/formula/geckodriver#default
brew install geckodriver

# hp driver
# ---------
# https://www.cyberciti.biz/faq/how-to-install-networked-hp-printer-and-scanner-on-ubuntu-linux/
sudo apt install hplip hplip-gui
hp-setup $PRINTER_IP

# MacOS caps lock / escape swap
# -----------------------------
# https://stackoverflow.com/a/46460200
# https://apple.stackexchange.com/a/283253

# Homebrew
# --------
# https://brew.sh/

# basics
# ------

# update default bash from MacOs version
brew install \
  bash \
  pkg-config \
  go

# python / miniforge (+ other deps)
# ------------------
brew install python

brew install \
  pyenv \
  black \
  cairo \
  ctags \
  cmake \

# utilities
# ---------
# git
brew install \
  git \
  git-lfs \
  git-filter-repo

# terminal
brew install \
  neovim \
  htop \
  tmux \
  rsync \
  gh \
  fd \
  ripgrep \
  tree \
  bat \
  rename \
  jq \
  entr \
  aria2 \
  awk \
  wget \
  curl \
  gnu-tar \
  djvu2pdf \
  xz \
  pdfgrep \
  7za \

# media & documents

# https://pandoc.org/org
# https://htop.dev/

brew install \
  imagemagick \
  gifsicle \
  pandoc \
  yt-dlp \
  shntool \
  librsvg

# https://github.com/yt-dlp/yt-dlp
# https://formulae.brew.sh/formula/librsvg
# https://formulae.brew.sh/formula/shntool#default

# https://trac.ffmpeg.org/wiki/CompilationGuide/macOS#Additionaloptions

brew tap homebrew-ffmpeg/ffmpeg
brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-librsvg --with-webp

# gui sofware
brew install --cask \
  mactex \
  calibre \
  lyx \
  inkscape \
  scribus \
  rar

# qr codes
# https://formulae.brew.sh/formula/qrencode
brew install qrencode

# Llama CPP
# https://github.com/ggerganov/llama.cpp
brew install llama.cpp

# Ollama
# https://ollama.com/
brew install ollama

# Screen Copy (Android screen on laptop)
# https://github.com/Genymobile/scrcpy
brew install scrcpy

# gchmod/gchown
# https://unix.stackexchange.com/a/613296
brew install coreutils

# python uv
https://docs.astral.sh/uv/
curl -LsSf https://astral.sh/uv/install.sh | sh

# skim
brew install --cask skim

# # c++ things
# brew install \
#   llvm \
#   lld \
#   libomp

# https://mpv.io/
brew install mpv

# pango: https://www.gtk.org/docs/architecture/pango
# https://formulae.brew.sh/formula/pango
# https://formulae.brew.sh/formula/gobject-introspection
# https://formulae.brew.sh/formula/pygobject3
brew install pango gobject-introspection pygobject3

# codex
curl -fsSL https://chatgpt.com/codex/install.sh | sh

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# # PostgreSQL
# brew install libpq

# # Elasticsearch
# # https://stackoverflow.com/questions/37876010/how-to-install-elasticsearch-as-a-service-using-brew
# brew tap elastic/tap
# brew install elastic/tap/elasticsearch-full
# brew services start elastic/tap/elasticsearch-full

# # openjdk
# # https://stackoverflow.com/questions/74547190/popup-error-openjdk-11-0-2-is-damaged-and-cant-be-opened-on-mac-os-ventura
# brew install openjdk@17

# opencode
curl -fsSL https://opencode.ai/install | bash

# google colab cli
# https://github.com/googlecolab/google-colab-cli
uv tool install google-colab-cli
