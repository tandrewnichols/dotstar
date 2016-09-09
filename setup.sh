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
  brew install wget git bash tmux imagemagick tree ttygif ttyrec postgresql gnupg ag jenv

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
  brew ls --version google-chrome || brew cask install google-chrome

else # If this is Linux
  sudo apt-get update
  sudo apt-get install vim git-all tmux imagemagick tree xclip

  install_google_chrome() {
    cd /tmp
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    cd -
  }

  # Install Google Chrome if not already installed
  type google-chrome >/dev/null 2>&1 || install_google_chrome

  # Make google-chrome open correctly
  perl -pi -e 's|^Exec=.*|Exec=(?!%U)/opt/google/chrome/chrome %U|' ~/.local/share/applications/google-chrome.desktop

  # Install jenv
  git clone https://github.comgcuisinier/jenv.git ~/.jenv
fi

# Install RVM and the latest ruby version
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash
source ~/.bashrc
rvm install ruby --latest
gem install bundler rails
gem install travis -v 1.8.1 --no-rdoc --no-ri

# Create common directories
mkdir -p $HOME/code/anichols/{apps,forks,generators,gists,grunt-plugins,manta,modules,vim-plugins}

# Generate a key in ~/.ssh/id_rsa with no password
ssh-keygen -t rsa -b 4096 -C "tandrewnichols@gmail.com" -f ~/.ssh/id_rsa -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub
# Open the ssh settings page on github
nohup xdg-open https://github.com/settings/ssh >& /dev/null &

# Clone vim-plugins so that +PlugInstall works
git clone git@github.com:tandrewnichols/vim-graft.git $HOME/code/anichols/vim-plugins
git clone git@github.com:tandrewnichols/vim-graft-node.git $HOME/code/anichols/vim-plugins
git clone git@github.com:tandrewnichols/vim-graft-angular.git $HOME/code/anichols/vim-plugins

# Install dot files from git repo
git clone git@github.com:tandrewnichols/dotstar.git $HOME/code/anichols/dotstar
cd code/anichols/dotstar

# Setup vim plugins
vim +PlugInstall +qall

# Link all files
./create-links

# Install fonts for powerline
git clone git@github.com:powerline/fonts.git $HOME/code/powerline-fonts
$HOME/code/powerline-fonts/install.sh

# Setup n/node/npm
curl -L http://git.io/n-install | bash
n lts # latest v4
n 5.12.0
n latest # latest v6
~/n/bin/npm install -g grunt gulp

source ~/.bashrc

# Install neo4j-instance
mkdir ~/bin
curl -L https://raw.githubusercontent.com/tandrewnichols/neo4j-instance/master/neo4j-instance.sh > ~/bin/neo4j-instance && chmod +x ~/bin/neo4j-instance
