#!/bin/bash

#### ALIASES #### 
alias del="git ls-files --deleted | xargs git rm"
alias remotes="git branch -r"
alias master="git checkout master && git pull"
alias conflict="st | grep -P '^[A-Z]{2}'"
alias pg="pgadmin3"
alias vimf="MYVIMRC=~/.vimfrc ~/code/floo-vim/src/vim -u ~/.vimfrc"
alias playdev="export PLAY_ENV=\"dev\""
alias playtest="export PLAY_ENV=\"test\""
alias g="grunt"
alias i="npm i --save-dev grunt grunt-contrib-jshint jshint-stylish grunt-mocha-test grunt-mocha-cov mocha-lcov-reporter sinon proxyquire indeed mocha mocha-given coffee-script grunt-travis-matrix grunt-cli"
alias vim="vim -p"
alias me="_goto ~/code/anichols"
alias manta="_goto ~/code/anichols/manta"
alias mf="_goto ~/code/anichols/manta/manta-frontend"
alias server="_goto ~/code/anichols/manta/manta-frontend/server"
alias client="_goto ~/code/anichols/manta/manta-frontend/client"
alias tasks="_goto ~/code/anichols/manta/manta-frontend/tasks"
alias modules="_goto ~/code/anichols/modules"
alias mod="_goto ~/code/anichols/modules"
alias apps="_goto ~/code/anichols/apps"
alias forks="_goto ~/code/anichols/forks"
alias play="~/code/anichols/manta/play"

# Linux specific aliases
if [[ $OSTYPE != darwin* ]]; then
  echo "OS is not darwin. Adding Linux aliases."
  alias ack="ack-grep"
  alias open="xdg-open"
  alias gimme="sudo apt-get install"
fi

#### GENERIC COMMANDS ####
wd() {
  if [ -z $1 ]; then
    grunt chrome
  else
    for ((i=1;i<=$1;i++))
    do
      grunt chrome
    done
  fi
}

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

src_usage() {
cat << EOF
usage: srcrr options

Sync the current repository to a sandbox using srcrr.

OPTIONS:
-c Command: the default is 'sync'. Other options are 'reset' and 'config'.
-s Sandbox: the sandbox to sync to
-p Port: the port to sync to
-l Log: log the command before executing
-v Verbose: turn on logging
EOF
}

# srcrr sync
src() {
  if [[ -n $1 ]] && [ "$1" == "help" ]; then
    src_usage
    return
  fi
  
  line="node /Users/AndrewNichols/code/anichols/manta/srcrr-client/srcrr"
  command="sync"
  sandbox=
  port=
  log=0
  verbose=0
  OPTIND=1
  while getopts ":c:s:p:lv" opt
  do
    case $opt in
      c)
        command="$OPTARG"
        ;;
      s)
        sandbox="$OPTARG"
        ;;
      p)
        port="$OPTARG"
        ;;
      l)
        log=1
        ;;
      v)
        verbose=1
        ;;
      ?)
        src_usage
        return
        ;;
    esac
  done
  
  if [ $command = "config" ]; then
    shift; shift;
    line="$line $command $@"
    $line
    return
  fi
  
  if [ $(echo $sandbox | grep -c "^[0-9]\{2,3\}$") -gt 0 ]; then
    sandbox="ecnext$sandbox.ecnext.com"
  elif [ $(echo $sandbox | grep -c "^[a-z]\{1,\}$") -gt 0 ]; then
    sandbox="$sandbox-sbx"
  elif [ $(echo $sandbox | grep -c "^[0-9]\{1,3\}\.[0-9]\{1,3\}$") -gt 0 ]; then
    sandbox="192.168.$sandbox"
  fi
  
  line="$line $command"
  if [[ -n $sandbox ]]; then
    line="$line -s $sandbox"
  fi
  
  if [[ -n $port ]]; then
    line="$line -p $port"
  fi
  
  if [ $verbose -eq 1 ]; then
    line="$line -v"
  fi
  
  if [ $log -eq 1 ]; then
    echo $line
  fi
  $line
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

subid() {
  echo '1hgfcmbh1s5xdn1'
  echo '1hgfcmbh1s5xdn1' | xclip -selection clipboard
}

resolve() {
  vim $(conflict | sed s/^...//)
}

#### GIT COMMANDS ####
# delete remote 
dr() {
  if [ -z $1 ]; then
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" = "master" ]; then
      echo "You're on master, stupid"
    else
      git push origin :$branch
    fi
  else
    if [ "$1" = "master" ]; then
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
  if [ $(git status -s | grep -c ".*") -eq 0 ]; then
    git status
  else
    git status -s
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
      git checkout master
    fi
    git branch -D $1
  else
    git checkout master
    git branch -D $branch
  fi
}

push() {
  exists=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
  if [[ -n $exists ]]; then
    git push
  else
    git push -u origin $(git rev-parse --abbrev-ref HEAD)
  fi
}

findr() {
  remotes | grep $1
}

showme() {
  curl -i https://api.github.com/user/repos -u tandrewnichols | grep '"name":'
}

repo() {
  curl -X POST -H "Context-Type:application/json" -d '{"name":"'"$1"'","description":"'"$2"'","auto_init":true,"gitignore_template":"Node","license_template":"mit"}' https://api.github.com/user/repos -u tandrewnichols
  cloneme $1
  cd $1
}
