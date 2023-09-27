#!/usr/bin/env bash

# If this is a Mac
if [[ $OSTYPE == darwin* ]]; then
  # Install homebrew
  echo "\[\033[0;36m\]Installing homebrew.\[\033[0m\]"
  brew fake 2> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
  brew doctor
  brew tap homebrew/cask-fonts

  brew_install() {
    brew ls $1 2> /dev/null || brew install "$@"
  }

  echo "\[\033[0;36m\]Installing homebrew packages.\[\033[0m\]"
  # Install common brew packages, each separately so the whole chain doesn't end if one fails.
  brew_install wget
  brew_install git
  brew_install bash
  brew_install tmux
  brew_install imagemagick
  brew_install tree
  brew_install postgresql
  brew_install coreutils # Includes realpath
  brew_install cmake
  brew_install highlight
  brew_install fzf
  brew_install figlet
  brew_install fontconfig
  cask_install fontforge
  brew_install fswatch
  brew_install gawk
  brew_install gcc
  brew_install go
  brew_install hub
  brew_install pandoc
  brew_install python
  brew_install readline
  brew_install reattach-to-user-namespace
  brew_install ripgrep
  brew_install rust
  brew_install vim --HEAD
  brew_install gnu-sed
  brew_install gnu-tar
  brew_install gnu-which
  brew_install font-meslo-for-powerline
  brew_install font-meslo-lg-nerd-font

  # brew_install install
  # brew_install ttygif
  # brew_install ttyrec
  # brew_install gnupg
  # brew_install jenv
  # brew_install gnutls
  # brew_install jpeg
  # brew_install rsync
  # brew_install sqlite
  # brew_install tidy-html5
  # brew_install gnu-indent
  # brew_install grep
  # brew_install findutils
  # brew_install wdiff

  echo "\[\033[0;36m\]Updating shell to /usr/local/bin/bash.\[\033[0m\]"
  # Set shell as the updated bash
  sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
  sudo bash -c "echo /opt/homebrew/bin/bash >> /etc/shells"
  # chsh -s /usr/local/bin/bash

  # echo "\[\033[0;36m\]Installing Google Chrome via homebrew.\[\033[0m\]"
  # Install Google Chrome (brew cask FTW)
  # cask_install google-chrome

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

# echo "\[\033[0;36m\]Installing rvm and ruby.\[\033[0m\]"
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash
# source ~/.bashrc
# rvm install ruby --latest
# gem install bundler rails
# gem install travis -v 1.8.1 --no-rdoc --no-ri

# Create common directories
echo "\[\033[0;36m\]Creating common code directories.\[\033[0m\]"
mkdir -p $HOME/code/anichols/{apps,forks,modules,vim}


# Generate a key in ~/.ssh/github with no password
if [ ! -f ~/.ssh/github ]; then
  echo "\[\033[0;36m\]Generating ssh key for github\[\033[0m\]"
  ssh-keygen -t rsa -b 4096 -C "tandrewnichols@gmail.com" -f ~/.ssh/github -N ""
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github

  if [[ $OSTYPE == darwin* ]]; then
    cat ~/.ssh/github.pub | pbcopy
    nohup open https://github.com/settings/ssh >& /dev/null &
  else
    xclip -sel clip < ~/.ssh/github.pub
    # Open the ssh settings page on github
    nohup xdg-open https://github.com/settings/ssh >& /dev/null &
  fi

  read -p "Press [Enter] to resume install after adding key to github..."
fi

# Clone vim plugins so that +PlugInstall works
echo "\[\033[0;36m\]Cloning local vim plugins.\[\033[0m\]"
git clone git@github.com:tandrewnichols/vim-vigor.git $HOME/code/anichols/vim/vim-vigor
git clone git@github.com:tandrewnichols/vim-rumrunner.git $HOME/code/anichols/vim/vim-rumrunner
git clone git@github.com:tandrewnichols/vim-rebuff.git $HOME/code/anichols/vim/vim-rebuff
git clone git@github.com:tandrewnichols/vim-girlfriend.git $HOME/code/anichols/vim/vim-girlfriend
git clone git@github.com:tandrewnichols/vim-determined.git $HOME/code/anichols/vim/vim-determined
git clone git@github.com:tandrewnichols/vim-whelp.git $HOME/code/anichols/vim/vim-whelp
git clone git@github.com:tandrewnichols/vim-headfirst.git $HOME/code/anichols/vim/vim-headfirst
git clone git@github.com:tandrewnichols/vim-docile.git $HOME/code/anichols/vim/vim-docile
git clone git@github.com:tandrewnichols/vim-contemplate.git $HOME/code/anichols/vim/vim-contemplate
git clone git@github.com:tandrewnichols/vim-dadbod-extensions.git $HOME/code/anichols/vim/vim-dadbod-extensions
git clone git@github.com:tandrewnichols/vim-debug.git $HOME/code/anichols/vim/vim-debug
git clone git@github.com:tandrewnichols/vim-replete.git $HOME/code/anichols/vim/vim-replete
git clone git@github.com:tandrewnichols/vim-tapir.git $HOME/code/anichols/vim/vim-tapir
git clone git@github.com:tandrewnichols/vim-textobj-xmlattr.git $HOME/code/anichols/vim/vim-textobj-xmlattr

# Install dot files from git repo
# echo "\[\033[0;36m\]Cloning dotfiles.\[\033[0m\]"
# ls $HOME/code/anichols/dotstar 2> /dev/null || git clone git@github.com:tandrewnichols/dotstar.git $HOME/code/anichols/dotstar
# cd code/anichols/dotstar

echo "\[\033[0;36m\]Installing Plug.\[\033[0m\]"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s vim/plugins.vim ~/.vim/plugins.vim

# Link all files
echo "\[\033[0;36m\]Linking files.\[\033[0m\]"
./create-links

# Install fonts for powerline
# echo "\[\033[0;36m\]Installing powerline.\[\033[0m\]"
# git clone git@github.com:powerline/fonts.git $HOME/code/powerline-fonts
# $HOME/code/powerline-fonts/install.sh

echo "\[\033[0;36m\]Installing tpm for tmux-plugins.\[\033[0m\]"
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Setup n/node/npm
echo "\[\033[0;36m\]Installing n/node/npm.\[\033[0m\]"
curl -L http://git.io/n-install | bash

# echo "\[\033[0;36m\]Installing common global node modules.\[\033[0m\]"
$HOME/n/bin/npm install -g jsctags
$HOME/n/bin/npm install -g tern-jsx
$HOME/n/bin/npm install -g typescript
$HOME/n/bin/npm install -g whimsy
$HOME/n/bin/npm install -g wip
# $HOME/n/bin/npm install -g grunt-cli
# $HOME/n/bin/npm install -g gulp
# $HOME/n/bin/npm install -g babel
# $HOME/n/bin/npm install -g bower
# $HOME/n/bin/npm install -g chalk-cli
# $HOME/n/bin/npm install -g codeclimate-test-reporter
# $HOME/n/bin/npm install -g coffee-script
# $HOME/n/bin/npm install -g coffeelint
# $HOME/n/bin/npm install -g copy-paste
# $HOME/n/bin/npm install -g create-react-app
# $HOME/n/bin/npm install -g decaffeinate
# $HOME/n/bin/npm install -g depcheck
# $HOME/n/bin/npm install -g electron
# $HOME/n/bin/npm install -g eslint
# $HOME/n/bin/npm install -g eslint-plugin-react
# $HOME/n/bin/npm install -g fixjson
# $HOME/n/bin/npm install -g grasp
# $HOME/n/bin/npm install -g grunt-init
# $HOME/n/bin/npm install -g gulp-cli
# $HOME/n/bin/npm install -g how2
# $HOME/n/bin/npm install -g htmlhint
# $HOME/n/bin/npm install -g instant-markdown-d
# $HOME/n/bin/npm install -g istanbul
# $HOME/n/bin/npm install -g jasmine-node
# $HOME/n/bin/npm install -g js-beautify
# $HOME/n/bin/npm install -g jsonlint
# $HOME/n/bin/npm install -g karma-cli
# $HOME/n/bin/npm install -g less
# $HOME/n/bin/npm install -g loadtest
# $HOME/n/bin/npm install -g mocha
# $HOME/n/bin/npm install -g nd
# $HOME/n/bin/npm install -g npm-check
# $HOME/n/bin/npm install -g npm-name-cli
# $HOME/n/bin/npm install -g npm-remote-ls
# $HOME/n/bin/npm install -g nyc
# $HOME/n/bin/npm install -g plato
# $HOME/n/bin/npm install -g rename
# $HOME/n/bin/npm install -g renamer
# $HOME/n/bin/npm install -g speed-test
# $HOME/n/bin/npm install -g stylelint
# $HOME/n/bin/npm install -g stylelint-config-recommended
# $HOME/n/bin/npm install -g svgo
# $HOME/n/bin/npm install -g tern-gulp
# $HOME/n/bin/npm install -g tern-jasmine
# $HOME/n/bin/npm install -g trombone
# $HOME/n/bin/npm install -g uglify-js
# $HOME/n/bin/npm install -g unused-deps
# $HOME/n/bin/npm install -g vimdebug
# $HOME/n/bin/npm install -g webpack
# $HOME/n/bin/npm install -g yo

source ~/.bashrc

# Build YouCompleteMe
# cd ~/.vim/plugged/YouCompleteMe
# ./install.py --all
# cd -

# Install neo4j-instance
curl -sSL https://raw.githubusercontent.com/tandrewnichols/ineo/master/ineo | bash -s install
source ~/.bashrc

# Clone manta-frontend so I can set up local gitconfig stuff
# git clone git@github.com:mantacode/manta-frontend.git $HOME/code/anichols/manta/manta-frontend
# git clone git@github.com:mantacode/fe-directory.git $HOME/code/anichols/manta/fe-directory
# git clone git@github.com:mantacode/dev-hub.git $HOME/code/anichols/manta/dev-hub
# git clone git@github.com:mantacode/cli-tools.git $HOME/code/anichols/manta/cli-tools
# git clone git@github.com:mantacode/gateway-api.git $HOME/code/anichols/manta/gateway-api
# git clone git@github.com:mantacode/launchpad-service.git $HOME/code/anichols/manta/launchpad-service
# git clone git@github.com:mantacode/node-utils.git $HOME/code/anichols/manta/node-utils
# git clone git@github.com:mantacode/prebid-service.git $HOME/code/anichols/manta/prebid-service
# cd $HOME/code/anichols/manta/manta-frontend
# git config --local user.name "Andrew Nichols"
# git config --local user.email "anichols@manta.com"
# cd $HOME

vim -u NONE -c "PlugInstall" -c q

echo "Don't forget the following manual steps:"
echo ""
echo "  \[\033[1;30m\]1\[\033[0m\]. Run tmux \[\033[0;32m\]Prefix + I\[\033[0m\] to install tmux plugins"
echo "  \[\033[1;30m\]2\[\033[0m\]. Exit and restart your shell so you're using the right version of vim"
echo "  \[\033[1;30m\]3\[\033[0m\]. Set your Terminal font to \[\033[0;32m\]Meslo LG S Powerline, Regular 12 point\[\033[0m\]"
echo "  \[\033[1;30m\]4\[\033[0m\]. Run \[\033[0;32m\]defaults write com.apple.screencapture name "Screenshot"\[\033[0m\] and \[\033[0;32m\]defaults write com.apple.screencapture include-date -bool false\[\033[0m\] and then \[\033[0;32m\]killall SystemUIServer\[\033[0m\] to make screenshots correct. Also disable thumbnails with Cmd-Shift-5."
