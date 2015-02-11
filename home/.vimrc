" Bundles
let g:osName = substitute(system('uname'), "\n", "", "")
source ~/.vim/vundle.vim

filetype plugin indent on 
let mapleader = "\<Space>"

" Plugins
source ~/.vim/plugins.vim
" Configuration
source ~/.vim/config.vim
" Mappings
source ~/.vim/mappings.vim
" Custom Functions
source ~/.vim/functions.vim

" Copy to/paste from system clipboard
if g:osName == 'Darwin'
  source ~/.vim/mac.vim
else
  source ~/.vim/linux.vim
endif

