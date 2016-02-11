" Bundles
let g:osName = substitute(system('uname'), "\n", "", "")
let $BASH_ENV = "~/.bash_aliases"
source ~/.vim/vundle.vim

filetype plugin indent on 
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Plugins
source ~/.vim/plugins.vim
" Configuration
source ~/.vim/config.vim
" Mappings
source ~/.vim/mappings.vim
" Custom Functions
source ~/.vim/functions.vim
