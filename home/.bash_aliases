#!/usr/bin/env bash

shopt -s expand_aliases

#### PRE-ADDED ALIASES ####

# enable color support of ls and also add handy aliases
if [[ -n `command -v dircolors` ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto -G'
  alias la='ls --color=auto -AG'
  alias ll='ls --color=auto -AlG'
  alias l='ls --color=auto -CG -1'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -G'
  alias la='ls -AG'
  alias ll='ls -AlG'
  alias l='ls -CG -1'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#### CUSTOM ALIASES ####
alias del="git ls-files --deleted | xargs git rm"
alias remotes="git branch -r"
alias pg="pgadmin3"
alias me="_goto ~/code/anichols"
alias h="_goto ~/code/anichols/ht"
alias modules="_goto ~/code/anichols/modules"
alias apps="_goto ~/code/anichols/apps"
alias forks="_goto ~/code/anichols/forks"
# alias generators="_goto ~/code/anichols/generators"
# alias plugins="_goto ~/code/anichols/grunt-plugins"
alias vp="_goto ~/code/anichols/vim"
alias neo="neo4j-instance"
alias vi="vim"
alias vimbones="vim --cmd 'let g:bones=1'"
alias vimpure="vim --cmd 'let g:noplugins=1'"
alias neo=ineo
alias ..="cd .."
alias aliases="rg \"^ *alias\" ~/.bash_aliases"
alias functions="rg \"^[a-zA-Z]+\(\)\" ~/.bash_aliases"
alias dd='clear'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias co='git branch-select -l'
alias dc='docker compose'
alias ok='git ok'
alias fixcap="hidutil property --set '{\"CapsLockDelayOverride\":1}'"

# export ll=src/renderers/screens/loopLibrary

# Linux specific aliases
if [[ $OSTYPE != darwin* ]]; then
  alias ack="ack-grep"
  open() {
    xdg-open "$*" </dev/null &>/dev/null &
  }
  alias gimme="sudo apt-get install"
fi

#### GENERIC COMMANDS ####
profile() {
  re='^[0-9]+$'
  if [[ $1 =~ $re ]]; then
    time (for ((i=1;i<=$1;i++)); do "${@:2}"; done;)
  else
    echo "First argument must be number of iterations"
  fi
}

_goto() {
  if [ -n $2 ]; then
    cd $1/$2
  else
    cd $1
  fi
}

up() {
  if [ -z $1 ]; then
    cd ..
  else
    for ((n=0;n<$1;n++))
    do
      cd ..
    done
  fi
}

linkFiles() {
  from=$(pwd)
  if [[ -n $1 ]]; then
    from=$from/$1
  fi
  from=$from/*
  to=${2:-~}
  if [! -d $to ]; then
    mkdir $to    
  fi
  for file in $from
  do
    if [ -f $file ]; then
      echo "Linking $file to $to/$(basename $file)"
      ln -sb $file $to/$(basename $file)
    fi
  done
}

unlinkFiles() {
  from=$(pwd)
  if [ -n $1 ]; then
    from=$from/$1
  fi
  from=$from/*
  to=${2:-~}
  for file in $from
  do
    name=$(basename $file)
    if [ -h $to/$name ]; then
      echo "Removing $to/$name"
      unlink $to/$name
      if [ -e $to/$name~ ]; then
        echo "Restoring original"
        mv $to/$name~ $to/$name
      fi
    fi
  done
}

resolve() {
  vim $(conflict | sed s/^...//)
}

replace() {
  where=$(git rev-parse --show-toplevel)
  if [[ -n $4 ]]; then
    find=$1
    replace=$2
    with=$3
    where=$4
  elif [[ -n $3 ]]; then
    find=$1
    replace=$2
    with=$3
  else
    find=$1
    replace=$1
    with=$2
  fi
  cmd="rg -l \"$find\" $where | xargs sed -i 's/$replace/$with/g'"
  echo $cmd
  eval $cmd
}

#### GIT COMMANDS ####
# Open pull request for current branch
pr() {
  remote=`git url`
  branch=`git name`
  if [[ $remote =~ "github" ]]; then
    if isht; then
      card=${branch%%/*}
      open "$remote/compare/$branch?expand=1&title=[$card]"
    else
      open "$remote/compare/$branch?expand=1"
    fi
  elif [[ $remote =~ "bitbucket" ]]; then
    open "$remote/pull-requests/new?source=$branch&event_source=branch_list"
  else
    echo "The remote does not match any known git host."
  fi
}

gbrowse() {
  open `git url`
}

ghtag() {
  version=`git describe --tags`
  open `git url`/releases/new?tag=$version
}

release() {
  if [ -z $1 ]; then
    type=patch
  else
    type=$1
  fi
  npm version $type
  git push --tags
  git push
  ghtag
}

# delete remote 
dr() {
  if [ -z $1 ]; then
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" = "`git_default_branch`" ]; then
      echo "You're on `git_default_branch`, stupid"
    else
      git push origin :$branch
    fi
  else
    if [ "$1" = "`git_default_branch`" ]; then
      echo "That's a bad idea."
    else
      git push origin :$1
    fi
  fi
}

clone() {
  if [[ -n $2 ]]; then
    git clone git@github.com:$1.git $2
  else
    git clone git@github.com:$1.git
  fi
}

# status
st() {
  if [ -z $1 ]; then
    if [ $(git status -s | grep -c ".*") -eq 0 ]; then
      git status
    else
      git status -s
    fi
  else
    if [ $(git status -s $1 | grep -c ".*") -eq 0 ]; then
      git status $1
    else
      git status -s $1
    fi
  fi
}

conflict() {
  if [ -z $1 ]; then
    st | rg '^[A-Z]{2}'
  else
    st $1 | rg '^[A-Z]{2}'
  fi
}

isht() {
  url=$(git config --get remote.origin.url)
  if [[ "$url" = *hometownticketing* ]]; then
    return 0
  else
    return 1
  fi
}

# branch
br() {  
  if [ -z $1 ]; then
    git branch
  else 
    if git show-ref --verify --quiet "refs/heads/$1"; then
      git checkout $1
    else
      if remotes | grep -q $1$; then
        git checkout -t origin/$1
      else
        git checkout -b $1
      fi
    fi
  fi
}

# delete branch
db() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ -n $1 ]]; then
    if [ $branch = $1 ] || [ $branch = "heads/$1" ]; then
      git checkout `git_default_branch`
    fi
    git branch -D $1
  else
    git checkout `git_default_branch`
    git branch -D $branch
  fi
}

push() {
  exists=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
  if [[ -n $exists ]]; then
    git push "$@"
  else
    git push -u origin $(git rev-parse --abbrev-ref HEAD) "$@"
  fi
}

dirty() {
  if [[ -z $1 ]]; then
    vim `git status -s | sed s/^...//`
  else
    vim `git status -s $1 | sed s/^...//`
  fi
}

vimball() {
  dir=`pwd`
  if [[ $# < 2 ]]; then
    if [[ $# == 0 ]]; then
      version=1.0.0
    else
      version=$1
    fi
    parts=(${dir//\// })
    repo=${parts[-1]}
  elif [[ $# == 2 ]]; then
    repo=$1
    version=$2
  else
    echo "Function 'vimball' called with an incorrect number of arguments. Signature is vimball([repo], [version])"
  fi

  if ! [[ $repo =~ ^vim- ]]; then
    repo=vim-$repo
  fi

  if ! [[ `git describe --tags 2>&1` =~ ^fatal ]]; then
    oldversion=`git tag --list --sort=-creatordate | head -n 1`
    if [[ $oldversion =~ ^v ]]; then
      oldversion=${oldversion:1}
    fi

    if [[ $version == "patch" || $version == "minor" || $version == "major" ]]; then
      versionparts=(${oldversion//./ })
      major=${versionparts[0]}
      minor=${versionparts[1]}
      patch=${versionparts[2]}
      if [[ $version == "patch" ]]; then
        version=${major}.${minor}.$((patch + 1))
      elif [[ $version == "minor" ]]; then
        version=${major}.$((minor + 1)).0
      else
        version=$((major + 1)).0.0
      fi
    fi

    if [[ $version =~ ^v ]]; then
      version=${version:1}
    fi

    echo -e "Executing \033[0;32mrg -l \"$oldversion\" | xargs sed -i \"s/$oldversion/$version/g\"\033[0m"
    rg -l "$oldversion" | xargs sed -i "s/$oldversion/$version/g"
    echo
    echo -e "Commiting version \033[0;36m$version\033[0m"
    git commit -am "Version $version"
    git push
    echo
  fi

  echo -e "Tarring repo to \033[0;36m~/code/anichols/vim/dist/$repo-v$version.tar.gz\033[0m"
  cd ~/code/anichols/vim
  tar -zcvf dist/$repo-v$version.tar.gz $repo/{plugin,autoload,syntax,after,colors,compiler,ftplugin,indent,keymap,lang,macros,tools,print,spell,pack,tutor,ftdetect,doc/*.txt} 2> /dev/null
  cd $repo
  echo

  echo -e "Creating tag \033[0;36mv$version\033[0m"
  git tag v$version
  git push --tags
  open `git url`/releases/new?tag=v$version
  echo

  cd $dir
}

vimpublish() {
  version=`git tag --list --sort=-creatordate | head -n 1`

  if [[ $version == 'v1.0.0' ]]; then
    repo=`git repo`
    echo "Via Plug:

  Plug '$repo'
  :PlugInstall

Via Vundle:

  Plugin '$repo'
  :BundleInstall

Via NeoBundle:

  NeoBundle '$repo'
  :BundleInstall

Via Pathogen:

  git clone https://github.com/$repo.git ~/.vim/bundle/${PWD##*/}" | pbcopy
    open https://www.vim.org/scripts/add_script.php
  else
    open https://www.vim.org/account/index.php
  fi
}

lns() {
  ln -s `realpath $1` $2
}

jest() {
  cur=$PWD
  dir=`realpath --relative-to=. $(findup node_modules)`
  cd $dir && cd ..
  ./node_modules/.bin/jest "$@"
  cd $cur
}

findup() {
  local DIR=$(pwd)
  while [ ! -z "$DIR" ]; do
    if [ -e "$DIR/$1" ]; then
      echo $DIR/$1
      break
    else
      DIR="${DIR%\/*}"
    fi
  done
}

vf() {
  vim `fzf`
}

git_default_branch() {
  echo `git branch -rl '*/HEAD' | awk -F/ '{print $NF}'`
  # Local
  # echo `basename $(git symbolic-ref --short refs/remotes/origin/HEAD)`
  # echo `basename $(git rev-parse --abbrev-ref origin/HEAD)`
  # Server
  # echo `basename $(git remote show origin | sed -n '/HEAD branch/s/.*: //p')`
}

master() {
  git checkout `git_default_branch`
  git pull
}

main() {
  master
}
