#!/bin/bash

# https://stackoverflow.com/q/4774054
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=$(dirname $SCRIPT)
# echo "from src: $SCRIPTPATH"

brew bundle --file="~/dotfiles/install/01.essentials.brewfile"
# brew bundle --file="~/dotfiles/install/02.other.brewfile"

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

# rust https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src rustfmt-preview rust-analysis

# MacOS caps lock / escape swap
# https://www.karltarvas.com/macos-remap-a-key/
# place com.ldaws.CapsLockEscapeSwap.plist into ~/Library/LaunchAgents/ 

# uv (python) https://docs.astral.sh/uv/
curl -LsSf https://astral.sh/uv/install.sh | sh

# codex
curl -fsSL https://chatgpt.com/codex/install.sh | sh

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# google colab cli
# https://github.com/googlecolab/google-colab-cli
uv tool install google-colab-cli
