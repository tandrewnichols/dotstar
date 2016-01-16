let g:instant_markdown_slow = 1
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
let g:instant_markdown_slow = 1

Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-fugitive'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Gundo'
Plugin 'scrooloose/nerdcommenter'
Plugin 'moll/vim-node' 
Plugin 'mileszs/ack.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'tpope/vim-endwise'
Plugin 'int3/vim-taglist-plus'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'docunext/closetag.vim'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/Better-CSS-Syntax-for-Vim'
Plugin 'ap/vim-css-color'
Plugin 'rstacruz/sparkup'
Plugin 'kshenoy/vim-signature'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'lunaru/vim-less'
Plugin 'digitaltoad/vim-jade'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-scripts/ZoomWin'
Plugin 'milkypostman/vim-togglelist'
Plugin 'mutewinter/swap-parameters'
Plugin 'tpope/vim-dispatch'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'suan/vim-instant-markdown'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tom-dignan/Conque-Shell'
Plugin 'rdolgushin/play.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'stephpy/vim-yaml'
Plugin 'yegappan/mru'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-tbone'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

call vundle#end()
filetype plugin indent on 
