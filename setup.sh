#!/usr/bin/env bash

# If this is a Mac
if [[ $OSTYPE == darwin* ]]; then
  # Install homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew doctor

  # Add/install dupes
  brew tap homebrew/dupes

  # Install common brew packages
  brew install wget git bash tmux imagemagick tree ttygif ttyrec postgresql gnupg

  # Homebrew TODO
  #ack coreutils ctags fontconfig fontforge apple-gcc42 binutils diffutils gawk gnutls gzip screen watch
# TODO
#brew install ed --default-names
#brew install findutils --with-default-names
#brew install gawk
#brew install gnu-indent --with-default-names
#brew install gnu-sed --with-default-names
#brew install gnu-tar --with-default-names
#brew install gnu-which --with-default-names
#brew install gnutls
#brew install grep --with-default-names
#brew install gzip
#brew install screen
#brew install watch
#brew install wdiff --with-gettext
#brew install wget
 
  # Set shell as the updated bash
  sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
  chsh -s /usr/local/bin/bash

  # Install Google Chrome (brew cask FTW)
  brew cask install google-chrome

else # If this is Linux
  sudo apt-get update
  sudo apt-get install vim git-all tmux imagemagick tree

  # Install Google Chrome
  cd /tmp
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  cd -
fi

# Install RVM and Ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install bundler rails
gem install travis -v 1.8.1 --no-rdoc --no-ri

# Install dot files from git repo
mkdir -p $HOME/code/anichols
git clone https:/github.com/tandrewnichols/dotstar.git $HOME/code/anichols
$HOME/code/anichols/dotstar/create-links

# Setup vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Install fonts for powerline
git clone git@github.com:powerline/fonts.git $HOME/code/powerline-fonts
$HOME/code/powerline-fonts/install.sh

# Setup n/node/npm
curl -L http://git.io/n-install | bash

# Install neo4j-instance
curl -L https://raw.githubusercontent.com/tandrewnichols/neo4j-instance/master/neo4j-instance.sh > ~/bin/neo4j-instance && chmod +x ~/bin/neo4j-instance
