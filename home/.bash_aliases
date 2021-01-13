#!/usr/bin/env bash

shopt -s expand_aliases

#### PRE-ADDED ALIASES ####

# enable color support of ls and also add handy aliases
if [[ -n `command -v dircolors` ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto -G'
  alias la='ls --color=auto -AG'
  alias ll='ls --color=auto -AlG'
  alias l='ls --color=auto -CG'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -G'
  alias la='ls -AG'
  alias ll='ls -AlG'
  alias l='ls -CG'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#### CUSTOM ALIASES ####
alias mgrep='grep -rIn --exclude-dir=assets --exclude=*.log --exclude=prebid*.js --exclude-dir=.nyc_* --exclude=yslow.js --exclude-dir=.git --exclude-dir=instrumented --exclude-dir=node_modules --exclude-dir=reports --exclude-dir=public --exclude-dir=dist --exclude-dir=generated --exclude-dir=bower_components --exclude-dir=vendor --exclude-dir=coverage'
alias del="git ls-files --deleted | xargs git rm"
alias remotes="git branch -r"
alias master="git checkout master && git pull"
alias pg="pgadmin3"
alias me="_goto ~/code/anichols"
alias manta="_goto ~/code/anichols/manta"
alias olive="_goto ~/code/anichols/olive"
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
alias vp="_goto ~/code/anichols/vim"
alias neo="neo4j-instance"
alias vi="vim"
alias vimbones="vim --cmd 'let g:bones=1'"
alias vimpure="vim --cmd 'let g:noplugins=1'"
alias neo=ineo
alias ..="cd .."
alias r="ranger"
alias aliases="rg \"^ *alias\" ~/.bash_aliases"
alias functions="rg \"^[a-zA-Z]+\(\)\" ~/.bash_aliases"
alias dd='clear'
alias show='pygmentize -f terminal256 -O style=monokai -g'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

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

blogify() {
   mogrify -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
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
oops() {
  gitk --all $( git fsck --no-reflog | awk '/dangling commit/ {print $3}' )
}

# Open pull request for current branch
pr() {
  remote=`git url`
  if [[ $remote =~ "github" ]]; then
    open "$remote/compare/`git name`?expand=1"
  elif [[ $remote =~ "bitbucket" ]]; then
    open "$remote/pull-requests/new?source=`git name`&event_source=branch_list"
  else
    echo "The remote does not match any known git host."
  fi
}

gh() {
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
    st | grep -P '^[A-Z]{2}'
  else
    st $1 | grep -P '^[A-Z]{2}'
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

# Open current repo on Travis CI
ci() {
  open https://travis-ci.org/`git repo`/builds
}

# Open current repo on codeclimate
cc() {
  open https://codeclimate.com/github/`git repo`
}

clean() {
  where=$PWD
  if [[ where != $HOME && where != '/' ]]; then
    cd ..
    rm -rf $where
  fi
}

ifttt() {
  dir=$(git rev-parse --show-toplevel)
  cur=$(node -e "console.log(require('$dir/package.json').name)")
  version=$(node -e "console.log(require('$dir/package.json').version)")
  url="`git url`/releases/tag/v$version"
  echo "Tweeting the following message:"
  echo "I just published ${cur}@${version}. See $url for details."
  curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$cur"'","value2":"'"$version"'","value3":"'"$url"'"}' https://maker.ifttt.com/trigger/publish/with/key/nF2XsQsOWk0L65RkCo94H02eSCbpI7-mfNY4gp4zbtd
}

tweet() {
  tweet="$@"
  len=${#tweet}
  if [[ len -gt 280 ]]; then
    echo "Tweet is $len characters, which is too long."
  else
    curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$tweet"'"}' https://maker.ifttt.com/trigger/tweet/with/key/nF2XsQsOWk0L65RkCo94H02eSCbpI7-mfNY4gp4zbtd
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
