#!/usr/bin/zsh

# oh my zsh
# (zsh is the default shell on MacOS)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# homebrew
# https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# symlinking
ln -fs  ~/dotfiles/.vimrc ~/.vimrc

# neovim
# https://github.com/neovim/neovim/wiki/Installing-Neovim
mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after' >> ~/.config/nvim/init.vim
echo 'let &packpath = &runtimepath' >> ~/.config/nvim/init.vim
echo 'source ~/.vimrc' >> ~/.config/nvim/init.vim

# fixes for oh-my-zsh

# extended vim mode
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# plugins
vim -Es '+%s/plugins=(git)/plugins=(git gh vi-mode fzf gcloud docker docker-compose aws nvm)/e' '+x' ~/.zshrc 

# lazy mode
vim -Es "+g/^plugins=/norm ozstyle ':omz:plugins:gcloud' lazy yes" '+x' ~/.zshrc
vim -Es "+g/^plugins=/norm ozstyle ':omz:plugins:docker' lazy yes" '+x' ~/.zshrc
vim -Es "+g/^plugins=/norm ozstyle ':omz:plugins:docker-compose' lazy yes" '+x' ~/.zshrc
vim -Es "+g/^plugins=/norm ozstyle ':omz:plugins:aws' lazy yes" '+x' ~/.zshrc
vim -Es "+g/^plugins=/norm ozstyle ':omz:plugins:nvm' lazy yes" '+x' ~/.zshrc
# adding a newline before all those above
vim -Es "+g/^plugins=/norm o" '+x' ~/.zshrc

# sourcing
vim -u None -i None -Es '+g/^source/norm osource ~/dotfiles/.zshrc_src' '+x' ~/.zshrc

# fix for current repo
cd ~/dotfiles
git update-index --assume-unchanged ~/dotfiles/.zshrc_paths
cd ~

# symlinking oh-my-zsh config
for i in ~/dotfiles/oh-my-zsh/lib/*.zsh
do
  ln -s "$i"  ~/.oh-my-zsh/custom/
done

for d in  ~/dotfiles/oh-my-zsh/plugins/*
do
  ln -s $d ~/.oh-my-zsh/custom/plugins/
done
cd ~

# symlinking tmux
mkdir -p ~/.config/tmux
touch ~/.config/tmux/tmux.conf
ln -s ~/dotfiles/.tmux.conf ~/.config/tmux/tmux.conf

# tmux tpm
# https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

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


# -----------------------
source ~/.zshrc
