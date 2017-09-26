call plug#begin()

if !exists('g:bones')
  Plug 'tmhedberg/matchit'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-heroku'
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
  Plug 'Gundo'
  Plug 'scrooloose/nerdcommenter'
  Plug 'mhinz/vim-grepper' 
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'scrooloose/syntastic'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'docunext/closetag.vim'
  Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
  Plug 'ap/vim-css-color'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install tern-grunt tern-gulp tern-jasmine tern-jsx' }
  Plug 'majutsushi/tagbar'
  Plug 'rstacruz/sparkup'
  Plug 'kshenoy/vim-signature'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'lunaru/vim-less'
  Plug 'digitaltoad/vim-jade'
  Plug 'kchmck/vim-coffee-script'
  Plug 'milkypostman/vim-togglelist'
  Plug 'SirVer/ultisnips'
  Plug 'machakann/vim-swap'
  Plug 'benmills/vimux'
  Plug 'suan/vim-instant-markdown'
  Plug 'basepi/vim-conque'
  Plug 'unblevable/quick-scope'
  Plug 'stephpy/vim-yaml'
  Plug 'yegappan/mru'
  Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
  Plug 'dbakker/vim-projectroot'
  Plug 'airblade/vim-gitgutter'
  Plug 'YankRing.vim'
  Plug 'terryma/vim-expand-region'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line' "yil
  Plug 'kana/vim-textobj-entire' "yie
  Plug 'kana/vim-textobj-indent' "yii
  Plug 'kana/vim-textobj-function' "yif
  Plug 'thinca/vim-textobj-function-javascript' "yif
  Plug 'kana/vim-textobj-syntax' "yiy
  Plug 'Julian/vim-textobj-variable-segment' "yiv
  Plug 'tandrewnichols/vim-textobj-xmlattr' "yix
  Plug 'glts/vim-textobj-comment' "yic
  Plug 'whatyouhide/vim-textobj-erb' "yiE
  Plug 'gilligan/textobj-gitgutter' "yih
  Plug 'kana/vim-textobj-lastpat' "yi/ and yi?
  Plug 'adriaanzon/vim-textobj-matchit' "yim
  Plug 'reedes/vim-textobj-quote' "yiq
  Plug 'saihoooooooo/vim-textobj-space' "yiS
  Plug 'jceb/vim-textobj-uri' "yiu
  Plug 'jasonlong/vim-textobj-css' "yic
  Plug 'kana/vim-textobj-datetime' "yid{a,d,f,t,z}
  Plug 'leafgarland/typescript-vim'
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-grex'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'kana/vim-submode'
  Plug 'skwp/greplace.vim'
  Plug 'wellle/targets.vim'
  Plug 'szw/vim-g'
  Plug 'AndrewRadev/switch.vim'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'thinca/vim-visualstar'
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'genutils'
  Plug 'godlygeek/tabular'
  Plug 'janko-m/vim-test'
  Plug 'ynkdir/vim-vimlparser'
  Plug 'syngan/vim-vimlint'
  Plug 'Valloric/YouCompleteMe'
  Plug 'ervandew/supertab'
  Plug 'tommcdo/vim-exchange'
  Plug 'artnez/vim-wipeout'

  " Local plugins
  Plug '~/code/anichols/vim-plugins/vim-graft'
  Plug '~/code/anichols/vim-plugins/vim-graft-node'
  Plug '~/code/anichols/vim-plugins/vim-graft-angular'
  Plug '~/code/anichols/vim-plugins/vim-graft-vim'
endif

Plug 'flazz/vim-colorschemes'
Plug 'christoomey/vim-tmux-navigator'

" ???
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'guns/vim-sexp'

call plug#end()
