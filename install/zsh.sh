# zsh and oh-my-zsh
#------------------
# https://github.com/ohmyzsh/ohmyzsh
echo "---------------------------"
echo "installing zsh & oh-my-zsh"
sudo apt install zsh -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

