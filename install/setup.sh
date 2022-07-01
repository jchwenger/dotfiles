#!/usr/bin/zsh

# symlinking
ln -fs  ~/dotfiles/.zshrc_src ~/.src_zshrc
ln -fs  ~/dotfiles/.vimrc ~/.vimrc

# fixes for oh-my-zsh

# extended vim mode
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

vim ~/.zshrc '+:execute ":silent! %s/plugins=(git)/export NVM_LAZY=1\rplugins=(git vi-mode fzf gcloud docker docker-compose gh fd aws nvm)/e | wq"'
vim ~/.zshrc '+:execute "norm /^sourceosource ~/.zshrc_src:wq"'

# fix for current repo
cd ~/dotfiles
git update-index --assume-unchanged ~/dotfiles/.zshrc_paths
cd ~

# symlinking oh-my-zsh
ln -s ~/dotfiles/oh-my-zsh/lib  ~/.oh-my-zsh/custom/lib
rm -rf ~/.oh-my-zsh/custom/plugins
ln -s ~/dotfiles/oh-my-zsh/plugins ~/.oh-my-zsh/custom/plugins

# symlinking tmux
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

source ~/.zshrc
