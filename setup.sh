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
  brew install wget git bash tmux imagemagick tree ttygif ttyrec postgresql gnupg ag jenv cmake fzf figlet fontconfig fontforge gswatch gawk gcc46 gifsickle gnu-sed gnu-tar gnutls go highlight hub jpeg jpegoptim openjpeg openssh openssl optipng pandoc phantomjs pixman pkg-config pngout python ranger readline reattach-to-user-namespace ripgrep rsync rust sqlite tidy-html5 upx urlview w3m yank

  brew install gnu-indent gnu-sed gnu-tar gnu-which grep findutils --with-default-names
  brew install wdiff --with-gettext
 
  # Set shell as the updated bash
  sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
  chsh -s /usr/local/bin/bash

  # Install Google Chrome (brew cask FTW)
  brew ls --version google-chrome || brew cask install google-chrome

else # If this is Linux
  sudo add-apt-repository -y ppa:pi-rho/dev
  sudo apt-get -y purge runit git-all git
  sudo apt-get -y autoremove
  sudo apt-get -y update
  sudo apt-get --yes --force-yes install git-daemon-sysvinit git-all tmux imagemagick tree xclip google-chrome-stable python-software-properties software-properties-common vim-gtk build-essential cmake python-dev python3-dev

  install_google_chrome() {
    cd /tmp
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    cd -
  }

  # Install Google Chrome if not already installed
  # Not necessary? Install with apt-get above...
  # type google-chrome >/dev/null 2>&1 || install_google_chrome

  # Make google-chrome open correctly
  perl -pi -e 's|^Exec=.*|Exec=(?!%U)/opt/google/chrome/chrome %U|' ~/.local/share/applications/google-chrome.desktop

  # Install jenv
  git clone https://github.com/gcuisinier/jenv.git ~/.jenv
fi

# Install RVM and the latest ruby version
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash
source ~/.bashrc
rvm install ruby --latest
gem install bundler rails
gem install travis -v 1.8.1 --no-rdoc --no-ri

# Create common directories
mkdir -p $HOME/code/anichols/{apps,forks,generators,gists,grunt-plugins,manta,modules,vim}

# Generate a key in ~/.ssh/id_rsa with no password
ssh-keygen -t rsa -b 4096 -C "tandrewnichols@gmail.com" -f ~/.ssh/id_rsa -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

if [[ $OSTYPE == darwin* ]]; then
  cat ~/.ssh/id_rsa.pub | pbcopy
  nohup open https://github.com/settings/ssh >& /dev/null &
else
  xclip -sel clip < ~/.ssh/id_rsa.pub
  # Open the ssh settings page on github
  nohup xdg-open https://github.com/settings/ssh >& /dev/null &
fi

read -p "Press [Enter] to resume install after adding key to github..."

# Clone vim plugins so that +PlugInstall works
git clone git@github.com:tandrewnichols/ale.git $HOME/code/anichols/forks/ale
git clone git@github.com:tandrewnichols/vim-vigor.git $HOME/code/anichols/vim/vim-vigor
git clone git@github.com:tandrewnichols/vim-rumrunner.git $HOME/code/anichols/vim/vim-rumrunner
git clone git@github.com:tandrewnichols/vim-rebuff.git $HOME/code/anichols/vim/vim-rebuff
git clone git@github.com:tandrewnichols/vim-girlfriend.git $HOME/code/anichols/vim/vim-girlfriend

# Install dot files from git repo
git clone git@github.com:tandrewnichols/dotstar.git $HOME/code/anichols/dotstar
cd code/anichols/dotstar

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s vim/plugins.vim ~/.vim/plugins.vim

# Setup vim plugins
vim +PlugInstall +qall

# Link all files
./create-links

# Install fonts for powerline
git clone git@github.com:powerline/fonts.git $HOME/code/powerline-fonts
$HOME/code/powerline-fonts/install.sh
echo "Don't forget to set your Terminal font to Meslo LG S Regular for Powerline"

mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
echo "Run tmux Prefix + I to install tmux plugins"

# Setup n/node/npm
curl -L http://git.io/n-install | bash
~/n/bin/npm install -g grunt-cli gulp

source ~/.bashrc

# Build YouCompleteMe
cd ~/.vim/plugged/YouCompleteMe
./install.py --all
cd -

# Install neo4j-instance
curl -sSL https://raw.githubusercontent.com/tandrewnichols/ineo/master/ineo | bash -s install
source ~/.bashrc

# Clone manta-frontend so I can set up local gitconfig stuff
git clone git@github.com:mantacode/manta-frontend.git $HOME/code/anichols/manta/manta-frontend
git clone git@github.com:mantacode/manta-router.git $HOME/code/anichols/manta/manta-router
cd $HOME/code/anichols/manta/manta-frontend
git config --local user.name "Andrew Nichols"
git config --local user.email "anichols@manta.com"
cd $HOME
