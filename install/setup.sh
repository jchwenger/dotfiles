#!/usr/bin/zsh

# symlinking
ln -fs  ~/dotfiles/.zshrc_src ~/.src_zshrc
ln -fs  ~/dotfiles/.vimrc ~/.vimrc

# fixes for oh-my-zsh

# extended vim mode
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# plugins
vim ~/.zshrc '+:execute ":silent! %s/plugins=(git)/plugins=(git gh vi-mode fzf gcloud docker docker-compose aws nvm)/e | wq"'

# lazy mode
plugins_str='+:execute "norm /plugins=(gito'
plugins_str="${plugins_str}zstyle \':omz:plugins:gcloud\' lazy yes"
plugins_str="${plugins_str}zstyle \':omz:plugins:docker\' lazy yes"
plugins_str="${plugins_str}zstyle \':omz:plugins:docker-compose\' lazy yes"
plugins_str="${plugins_str}zstyle \':omz:plugins:aws\' lazy yes"
plugins_str="${plugins_str}zstyle \':omz:plugins:nvm\' lazy yes"
vim ~/.zshrc "${plugins_str} :wq\""

# sourcing
vim ~/.zshrc '+:execute "norm /^sourceosource ~/.zshrc_src:wq"'

# fix for current repo
cd ~/dotfiles
git update-index --assume-unchanged ~/dotfiles/.zshrc_paths
cd ~

# symlinking oh-my-zsh
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
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

source ~/.zshrc
