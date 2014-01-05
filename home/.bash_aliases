#!/bin/sh

#### ALIASES #### 
alias del="git ls-files --deleted | xargs git rm"
alias status="git status"
alias add="git add ."
alias server="cd ~/code/vagrant-tools/src/manta-frontend/server"
alias client="cd ~/code/vagrant-tools/src/manta-frontend/client"
alias remotes="git branch -r"
alias master="git checkout master"
alias conflict="st | grep 'U[U|D]'"
alias pg="pgadmin3"
alias ack="ack-grep"
alias open="xdg-open"

#### GENERIC COMMANDS ####
sub() {
  if [ -n $1 ]; then
    echo "opening sublime with $1"
    sublime $1
  else
    echo "opening sublime at ."
    sublime .
  fi
}

manta() {
  if [ -n $1 ]; then
    cd ~/code/vagrant-tools/src/$1
  else
    cd ~/code/vagrant-tools/src
  fi
}

legacy() {
  if [ -n $1 ]; then
    cd ~/code/legacy/$1
  else
    cd ~/code/legacy
  fi
}

me() {
  if [ -n $1 ]; then
    cd ~/code/anichols/$1
  else
    cd ~/code/anichols
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
  
  line="node /home/anichols/code/legacy/srcrr-client/srcrr"
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

#test() {
  #if [ -e ~/code/other/perltest.pl ]; then
    #perl ~/code/other/perltest.pl
  #fi
#}


linkFiles() {
  for file in $(pwd)/$1/*
  do
    if [ -f $file ]; then
      echo "Linking $file to $2/$(basename $file)"
      ln -sb $file $2/$(basename $file)
    fi
  done
}

unlinkFiles() {
  for file in $(pwd)/$1/*
  do
    name=$(basename $file)
    if [ -h $2/$name ]; then
      echo "Removing $2/$name"
      unlink $2/$name
      if [ -e $2/$name~ ]; then
        echo "Restoring original"
        mv $2/$name~ $2/$name
      fi
    fi
  done
}

subid() {
  echo '1hgfcmbh1s5xdn1'
  echo '1hgfcmbh1s5xdn1' | xclip -selection clipboard
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

gimme() {
  sudo apt-get install $1
}

clone() {
  if [ -n $2 ]; then
    git clone git@manta.github.com:mantacode/$1.git $2
  else
    git clone git@manta.github.com:mantacode/$1.git
  fi
}

cloneme() {
  if [ -n $2 ]; then
    git clone git@me.github.com:tandrewnichols/$1.git $2
  else
    git clone git@me.github.com:tandrewnichols/$1.git
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
      if git branch -r | grep -q $1$; then
        git checkout -t origin/$1
      else
        git checkout -b $1
      fi
    fi
  fi
}

revert() {
  git checkout HEAD $1
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

com() {
  git add .
  git commit -m "$1"
}

remote() {
  git branch -r | grep $1
}
