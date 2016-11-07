call plug#begin()

Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'scrooloose/nerdtree'
" TODO: try this out for loading nerdtree when opening a directory
"Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind'] }
"augroup nerd_loader
  "autocmd!
  "autocmd VimEnter * silent! autocmd! FileExplorer
  "autocmd BufEnter,VimEnter *
        "\  if isdirectory(expand('<amatch>'))
        "\|   call plug#load('nerdtree')
        "\|   execute 'autocmd! nerd_loader'
        "\| endif
"augroup END
Plug 'tpope/vim-surround'
Plug 'Gundo'
Plug 'scrooloose/nerdcommenter'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'flazz/vim-colorschemes'
Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
Plug 'ap/vim-css-color'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'majutsushi/tagbar'
Plug 'rstacruz/sparkup'
Plug 'kshenoy/vim-signature'
Plug 'terryma/vim-multiple-cursors'
Plug 'jlanzarotta/bufexplorer'
Plug 'lunaru/vim-less'
Plug 'digitaltoad/vim-jade'
Plug 'kchmck/vim-coffee-script'
Plug 'milkypostman/vim-togglelist'
Plug 'mutewinter/swap-parameters'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'suan/vim-instant-markdown'
Plug 'tom-dignan/Conque-Shell'
Plug 'tpope/vim-eunuch'
Plug 'unblevable/quick-scope'
Plug 'stephpy/vim-yaml'
Plug 'yegappan/mru'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-speeddating'
Plug 'dbakker/vim-projectroot'
Plug 'airblade/vim-gitgutter'
Plug 'YankRing.vim'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'leafgarland/typescript-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'kana/vim-submode'
Plug 'skwp/greplace.vim'
Plug 'kana/vim-textobj-function'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'szw/vim-g'
Plug 'AndrewRadev/switch.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'thinca/vim-visualstar'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-scriptease'
Plug 'AndrewRadev/linediff.vim'
Plug 'genutils'
Plug 'kana/vim-textobj-syntax'
Plug 'godlygeek/tabular'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'janko-m/vim-test'
Plug 'ynkdir/vim-vimlparser'
Plug 'syngan/vim-vimlint'

" Local plugins
Plug '~/code/anichols/vim-plugins/vim-graft'
Plug '~/code/anichols/vim-plugins/vim-graft-node'
Plug '~/code/anichols/vim-plugins/vim-graft-angular'

" ???
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'guns/vim-sexp'

call plug#end()
