#!/bin/bash
ZSHRC="./.zshrc"
VIMRC="./.vimrc"
YCM_CONF="./.ycm_extra_conf.py"
APT_PACKAGE="\
    zsh \
    tmux \
    python3 \
    python3-dev \
    python3-pip \
    python \
    python-dev \
    python-pip \
    vim \
    curl \
    git \
    gist \
    build-essential \
    make \
    cmake \
    htop \
    iotop \
    iftop \
    gcc \
    g++ \
    bison"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y $APT_PACKAGE

#zsh setup
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
zsh -c 'source ~/.zshrc; git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions'
chmod a-w -R zsh-autosuggestions
zsh -c 'source ~/.zshrc; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting'
chmod a-w -R zsh-syntax-highlighting
cp $ZSHRC ~/.zshrc
sudo chsh -s `which zsh` `whoami`


#docker setup
#curl -fsSL get.docker.com | sh
#sudo usermod -aG docker `whoami`

#nvm setup
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.nvm/nvm.sh
nvm install v10.0.0

#gvm setup
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source  ~/.gvm/scripts/gvm
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
export CGO_ENABLE=0
gvm install go1.9
gvm use go1.9 --default

#vim setup
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp $VIMRC ~/.vimrc
cp $YCM_CONF ~/.vim/
vim +PluginInstall +GoInstallBinaries +qall
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --go-completer
