#!/usr/bin/env bash

if [[ $OSTYPE == darwin* ]]; then
  # On mac, install homebrew and other packages
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew doctor
  brew install wget git bash tmux imagemagick tree ttygif ttyrec
  sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
  chsh -s /usr/local/bin/bash
else
  sudo apt-get update
  sudo apt-get install git-all tmux imagemagick tree
fi

# Install dot files from git repo
mkdir -p $HOME/code/anichols
git clone https:/github.com/tandrewnichols/dotstar.git $HOME/code/anichols
$HOME/code/anichols/create-links

# Setup vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Setup n/node/npm
curl -L http://git.io/n-install | bash

# Install neo4j-instance
curl -L https://raw.githubusercontent.com/tandrewnichols/neo4j-instance/master/neo4j-instance.sh > ~/bin/neo4j-instance && chmod +x ~/bin/neo4j-instance
