#!/usr/bin/zsh

# symlinking
ln -fs  ~/dotfiles/.zshrc_src ~/.src_zshrc
ln -fs  ~/dotfiles/.vimrc ~/.vimrc

# fixes for oh-my-zsh

# extended vim mode
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# rvm lazy
git clone https://github.com/FrederickGeek8/zsh-rvm-lazy ~/.oh-my-zsh/custom/plugins/zsh-rvm-lazy

vim ~/.zshrc '+:execute ":silent! %s/plugins=(git)/export NVM_LAZY=1\rplugins=(git vi-mode fzf gcloud docker docker-compose gh fd aws nvm zsh-rvm-lazy)/e | wq"'
vim ~/.zshrc '+:execute "norm /^sourceosource ~/.zshrc_src:wq"'

# fix for current repo
cd ~/dotfiles
git update-index --assume-unchanged ~/dotfiles/.zshrc_paths
cd ~

# symlinking oh-my-zsh
ln -s ~/dotfiles/oh-my-zsh/lib  ~/.oh-my-zsh/custom/lib
cd ~/.oh-my-zsh/custom/plugins
for d in  ~/dotfiles/oh-my-zsh/plugins/*
do
  ln -s $d
done
cd ~


# symlinking tmux
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

source ~/.zshrc
