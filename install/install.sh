#!/bin/bash

# https://stackoverflow.com/q/4774054
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
# echo "from src: $SCRIPTPATH"

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

# fzf
# ---
# https://github.com/junegunn/fzf
brew install fzf

# bat
# ---
# https://github.com/sharkdp/bat
brew install bat

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

# node / nvm
# ----------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.41.0/install.sh | bash
source ~/.zshrc
nvm install --lts
nvm use --lts

npm install -g http-server

# Rust
# ----
# https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src rustfmt-preview rust-analysis

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

# # Ruby
# # ----
# # https://jekyllrb.com/docs/installation/macos/
# brew install chruby ruby-install xz
# ruby-install ruby 3.4.1

# # Jekyll
# # ------
# # https://jekyllrb.com/docs/installation/macos/
# gem install jekyll

# # Gatsby
# # ------
# # https://www.gatsbyjs.org/
# npm install -g gatsby-cli

# Hugo
# ----
# https://gohugo.io/installation/macos/#package-managers
brew install hugo

# Yarn
# ----
# https://yarnpkg.com/getting-started/install
npm install -g corepack

# js-beautify
# -----------
# https://www.npmjs.com/package/js-beautify
npm -g install js-beautify

# remove Imagemagick policy restrictions
# https://askubuntu.com/a/1081907
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout
# to reverse:
# sudo mv /etc/ImageMagick-6/policy.xmlout /etc/ImageMagick-6/policy.xml

# webp tool
# ---------
# https://formulae.brew.sh/formula/webp
brew install webp

# cue/flac splitting
# ------------------
# https://danilodellaquila.com/en/blog/how-to-split-an-audio-flac-file-using-ubuntu-linux
# cuebreakpoints file.cue | shnsplit -o flac file.flac
sudo apt-get install cuetools shntool flac

# clang
# -----
# https://formulae.brew.sh/formula/llvm
brew install llvm

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
  gnu-sed \

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
#   lld \
#   libomp

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
