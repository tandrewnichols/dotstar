#!/usr/bin/env bash

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Gray="\[\033[1;30m\]"         # Gray
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# PS1 Formats
Time12a="\@"
PathShort="\W"

#$ ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM=xterm-256color
#if [[ $OSTYPE == darwin* ]]; then
  #export VIMRUNTIME=/usr/share/vim/vim73
#else
  #export VIMRUNTIME=/usr/share/vim/vim74
#fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

ssh-add ~/.ssh/github > /dev/null 2>&1

function get_ps1_path () {
  gitroot=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -eq 0 ]; then
    echo ${PWD/#$gitroot/$(basename $gitroot)}
  else
    echo ${PWD/#$HOME/\~}
  fi
}

if [ -f ~/.git-prompt.sh ]; then
  export GIT_PS1_SHOWDIRTYSTATE=
  # Updates git branch color based on dirty state
  export PS1=$Yellow'anichols'$Color_Off':'$Cyan'$(get_ps1_path)'$Color_Off'$(git branch &>/dev/null;\
  if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
      # @4 - Clean repository - nothing to commit
      echo "'$Green'"$(__git_ps1 " [%s]"); \
    else \
      # @5 - Changes to working tree
      echo "'$Red'"$(__git_ps1 " [%s]"); \
    fi)'$Color_Off'\$ "; \
  else \
    echo "'$Color_Off'\$ "; \
  fi)'
else
  export PS1='\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;36m\]\W\[\033[00m\]$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

export EDITOR=vim
export LINES=$LINES
export COLUMNS=$COLUMNS
export NEXUS_USERNAME="manta_ro"
export NEXUS_PASSWORD="px9tlR2IkNP60Y7D7vb2EpP6pRzdoSE7"
export PLAY_ENV="dev"
export LOG_PATH="~/code/anichols/manta/play/logs"
export MAVEN_HOME="/usr/local/Cellar/maven/3.6.1/libexec"
export USERNAME="anichols"

if [[ $OSTYPE == darwin* ]]; then
  export USERNAME=anichols
else
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
fi

# Pass extra keys through to vim
bind -r '\C-s'
stty -ixon

function add_after_path() {
  for arg in "$@"
  do
    [[ :$PATH: == *":$arg:"* ]] || PATH="$PATH:$arg"
  done
}

function add_before_path() {
  for arg in "$@"
  do
    [[ :$PATH: == *":$arg:"* ]] || PATH="$arg:$PATH"
  done
}

if [[ $OSTYPE == darwin* ]]; then
  for brewbin in coreutils grep gnu-sed gnu-tar gnu-indent gnu-which findutils wdiff
  do
    brewpath=/usr/local/opt/$brewbin/libexec
    add_before_path $brewpath/gnubin
    MANPATH="$brewpath/gnuman:$MANPATH"
  done
fi

add_after_path $HOME/bin:$HOME/.rvm/bin
add_after_path /usr/local/opt/go/libexec/bin:/usr/local/opt/rust/bin

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

ulimit -n 2560

if [ -f ~/.rvm/scripts/rvm ]; then
  source ~/.rvm/scripts/rvm
fi

set -o vi
export TREE_COLORS='di=00;36:ln=00;32:ex=00;31'
#export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

if [ -z $GRUNT_COMPLETION_INITIALIZED ]; then
  eval "$(grunt --completion=bash)"
  export GRUNT_COMPLETION_INITIALIZED=1
fi


jenv_init() {
  [[ -s "/Users/AndrewNichols/.jenv/bin/jenv-init.sh" ]] && source "/Users/AndrewNichols/.jenv/bin/jenv-init.sh" && source "/Users/AndrewNichols/.jenv/commands/completion.sh"
}

eval "$(hub alias -s)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

if [ -z "$TMUX" ]; then
  list=`tmux ls`
  if [ -z "$list" ]; then
    tmux new -s anichols
  else
    index=`echo "$list" | wc -l`
    index=$((index + 1))
    session=anichols${index}
    tmux new -s $session
  fi
fi

export W3MIMGDISPLAY_PATH=`which w3m`
export RANGER_LOAD_DEFAULT_RC=FALSE
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1

# export CDPATH=".:/Users/AndrewNichols/code/anichols/manta/manta-frontend:/Users/AndrewNichols/code/anichols/vim:/Users/AndrewNichols/code/anichols/modules:/Users/AndrewNichols/code/anichols/apps:/Users/AndrewNichols/code/anichols/generators:/Users/AndrewNichols/code/anichols/vim:/Users/AndrewNichols/code/anichols/grunt-plugins:/Users/AndrewNichols/code/anichols/forks:/Users/AndrewNichols/code/anichols"

[ -f ~/.config/manta/mf-completion.bash ] && source ~/.config/manta/mf-completion.bash

add_before_path ~/.npm-global/bin
add_after_path ~/apache-storm-1.0.2/bin

export INEO_HOME=/Users/andrew/.ineo
add_before_path $INEO_HOME/bin

export PATH
