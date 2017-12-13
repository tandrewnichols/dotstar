#!/usr/bin/env bash

shopt -s expand_aliases

#### PRE-ADDED ALIASES ####

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [[ $OSTYPE == darwin* ]]; then
  alias ls='ls -G'
  alias la='ls -AG'
  alias ll='ls -alGF'
  alias l='ls -CFG'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#### CUSTOM ALIASES ####
alias mgrep='grep -rIn --exclude-dir=assets --exclude=*.log --exclude=prebid*.js --exclude=yslow.js --exclude-dir=.git --exclude-dir=instrumented --exclude-dir=node_modules --exclude-dir=reports --exclude-dir=public --exclude-dir=dist --exclude-dir=generated --exclude-dir=bower_components --exclude-dir=vendor --exclude-dir=coverage'
alias del="git ls-files --deleted | xargs git rm"
alias remotes="git branch -r"
alias master="git checkout master && git pull"
alias conflict="st | grep -P '^[A-Z]{2}'"
alias pg="pgadmin3"
alias vimf="MYVIMRC=~/.vimfrc ~/code/floo-vim/src/vim -u ~/.vimfrc"
alias playdev="export PLAY_ENV=\"dev\""
alias playtest="export PLAY_ENV=\"test\""
alias vim="vim -p"
alias me="_goto ~/code/anichols"
alias manta="_goto ~/code/anichols/manta"
alias fe="_goto ~/code/anichols/manta/manta-frontend"
alias server="_goto ~/code/anichols/manta/manta-frontend/server"
alias client="_goto ~/code/anichols/manta/manta-frontend/client"
alias tasks="_goto ~/code/anichols/manta/manta-frontend/tasks"
alias modules="_goto ~/code/anichols/modules"
alias mod="_goto ~/code/anichols/modules"
alias apps="_goto ~/code/anichols/apps"
alias forks="_goto ~/code/anichols/forks"
alias generators="_goto ~/code/anichols/generators"
alias plugins="_goto ~/code/anichols/grunt-plugins"
alias play="_goto ~/code/anichols/manta/play"
alias vp="_goto ~/code/anichols/vim-plugins"
alias neo="neo4j-instance"
alias vi="vim -p"
alias vimbones="vim -p --cmd 'let g:bones=1'"
alias vimpure="vim -p --cmd 'let g:noplugins=1'"
alias neo=ineo

# Linux specific aliases
if [[ $OSTYPE != darwin* ]]; then
  alias ack="ack-grep"
  open() {
    xdg-open "$*" </dev/null &>/dev/null &
  }
  alias gimme="sudo apt-get install"
fi

#### GENERIC COMMANDS ####
g() {
  if [ -e $(git rev-parse --show-toplevel)/Gruntfile.js ] || [ -e $(git rev-parse --show-toplevel)/Gruntfile.coffee ]; then
    grunt $@
  elif [ -e $(git rev-parse --show-toplevel)/gulpfile.js ] || [ -e $(git rev-parse --show-toplevel)/gulpfile.coffee ]; then
    gulp $@
  else
    npm run $@
  fi
}

mk() {
  result=${PWD##*/}
  if [ $result == 'modules' ]; then
    generator=module
    dir=$1
  elif [ $result == 'grunt-plugins' ]; then
    generator=grunt
    if [[ $1 == grunt-* ]]; then
      dir=$1
    else
      dir="grunt-$1"
    fi
  elif [ $result == 'apps' ]; then
    generator=app
    dir=$1
  fi
  mkdir -p $dir
  cd $dir
  yo $generator $1
}

init() {
  result=${PWD##*/}
  git init
  if [ $1 == 'bb' ]; then
    git remote add origin https://bitbucket.org/tandrewnichols/$result
  else
    git remote add origin https://github.com/tandrewnichols/$result
  fi
}

wd() {
  if [ -z $1 ]; then
    grunt wd
  else
    for ((i=1;i<=$1;i++))
    do
      grunt wd
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

blogify() {
   mogrify -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

replace() {
  where=$(git rev-parse --show-toplevel)
  find=$1
  replace=$2
  cmd="mgrep -rl \"$1\" $where | xargs sed -i '' 's/$find/$replace/g'"
  echo $cmd
  eval $cmd
}

oops() {
  gitk --all $( git fsck --no-reflog | awk '/dangling commit/ {print $3}' )
}

#### GIT COMMANDS ####
# Open pull request for current branch
pr() {
  open https://github.com/`get_git_user_repo`/compare/`git rev-parse --abbrev-ref HEAD`?expand=1
}

ghtag() {
  version=`npm version | head -1 | grep -o "[0-9\.]\+"`
  open https://github.com/`get_git_user_repo`/releases/new?tag=v$version
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

get_git_user_repo() {
  remote=`git config --get remote.origin.url`
  remote=${remote#*:}
  remote=${remote:0: -4}
  echo $remote
}

# Open current repo on Travis CI
ci() {
  open https://travis-ci.org/`get_git_user_repo`/builds
}

# Open current repo on codeclimate
cc() {
  open https://codeclimate.com/github/`get_git_user_repo`
}
