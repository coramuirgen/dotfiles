#!/bin/sh

git clone https://github.com/rawaludin/dotfiles.git
ln -sf dotfiles/.bashrc .
source ~/.bashrc
ln -sf dotfiles/.gitconfig .
ln -sf dotfiles/.inputrc .
ln -sf dotfiles/.editrc .
ln -sf dotfiles/.tmux.conf .
ln -sf dotfiles/.config .

# directory structure
mkdir ~/code

# php
sudo apt-get install -y php php-mbstring php-xml php-zip curl php-cli git php-curl php-mysql php-xdebug
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# neovim
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim python3-dev python3-pip
sudo pip3 install --upgrade neovim
nvim +PlugInstall +qall

# important utility
sudo apt-get install silversearcher-ag
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
sudo dpkg -i ripgrep_0.8.1_amd64.deb

# example: open port
# sudo ufw allow 8080/tcp

# mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server
mysql -u root -proot -e "CREATE USER 'homestead'@'localhost' IDENTIFIED BY 'secret'"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'localhost';"
mysql -u homestead -psecret -e "create database homestead;"

# timezone
sudo timedatectl set-timezone Asia/Jakarta

# turnoff default apache2
sudo service apache2 stop

# zsh
# sudo apt-get install -y zsh
# sudo chsh -s `which zsh` $USER
# curl -sL zplug.sh/installer | zsh
