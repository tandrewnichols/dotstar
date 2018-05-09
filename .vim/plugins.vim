call plug#begin()

if !exists('g:bones')
  Plug 'tmhedberg/matchit'
  Plug 'MarcWeber/vim-addon-mw-utils'

  " Tim Pope plugins
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  " Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-heroku'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-ragtag'
  " If marcos with <Esc> don't work
  " try this instead.
  Plug 'vim-utils/vim-husk'
  " Plug 'tpope/vim-classpath'

  " Filetype plugins
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
  Plug 'ap/vim-css-color'
  Plug 'lunaru/vim-less'
  " Plug 'digitaltoad/vim-jade'
  Plug 'kchmck/vim-coffee-script'
  " Plug 'suan/vim-instant-markdown'
  Plug 'junegunn/vim-xmark', { 'do': 'make' }
  Plug 'stephpy/vim-yaml'
  " Plug 'leafgarland/typescript-vim'
  Plug 'ynkdir/vim-vimlparser'
  Plug 'syngan/vim-vimlint'
  Plug 'othree/csscomplete.vim'
  Plug 'rhysd/vim-gfm-syntax'
  Plug 'othree/html5.vim'

  Plug 'tomtom/tcomment_vim'
  Plug 'tomtom/tlib_vim'
  Plug 'mbbill/undotree'
  " Plug 'w0rp/ale'
  Plug '~/code/anichols/forks/ale'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'docunext/closetag.vim'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install tern-grunt tern-gulp tern-jasmine tern-jsx' }
  Plug 'majutsushi/tagbar'
  Plug 'rstacruz/sparkup'
  Plug 'kshenoy/vim-signature'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'milkypostman/vim-togglelist'
  Plug 'SirVer/ultisnips'
  Plug 'machakann/vim-swap'
  Plug 'benmills/vimux'
  Plug 'unblevable/quick-scope'
  Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
  Plug 'dbakker/vim-projectroot'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-scripts/YankRing.vim'
  Plug 'terryma/vim-expand-region'

  " Text object plugins
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-syntax'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-datetime'
  Plug 'thinca/vim-textobj-function-javascript'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'tandrewnichols/vim-textobj-xmlattr'
  Plug 'whatyouhide/vim-textobj-erb'
  Plug 'adriaanzon/vim-textobj-matchit'
  Plug 'reedes/vim-textobj-quote'
  Plug 'saihoooooooo/vim-textobj-space'
  Plug 'jceb/vim-textobj-uri'
  Plug 'glts/vim-textobj-comment'
  Plug 'jasonlong/vim-textobj-css'
  Plug 'coderifous/textobj-word-column.vim'
  Plug 'wellle/targets.vim'
  Plug 'tommcdo/vim-exchange'

  " Operator plugins
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-grex'

  " Plug 'Valloric/MatchTagAlways'
  Plug 'kana/vim-submode'
  Plug 'skwp/greplace.vim'
  Plug 'AndrewRadev/switch.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  " Plug 'AndrewRadev/linediff.vim'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'thinca/vim-visualstar'
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'vim-scripts/genutils'
  Plug 'godlygeek/tabular'
  Plug 'Valloric/YouCompleteMe'
  Plug 'ervandew/supertab'
  Plug 'artnez/vim-wipeout'
  Plug 'bkad/camelcasemotion'
  Plug 'junegunn/vim-emoji'
  Plug 'junegunn/vader.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-peekaboo'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'justinmk/vim-sneak'
  Plug 'lfilho/cosco.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'wellle/visual-split.vim'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-reload'

  " Local plugins
  " Plug '~/code/anichols/vim/vim-graft'
  " Plug '~/code/anichols/vim/vim-graft-node'
  " Plug '~/code/anichols/vim/vim-graft-angular'
  " Plug '~/code/anichols/vim/vim-graft-vim'
  Plug '~/code/anichols/vim/vim-vigor'
  Plug '~/code/anichols/vim/vim-rumrunner'
  Plug '~/code/anichols/vim/vim-rebuff'
  Plug '~/code/anichols/vim/vim-girlfriend'

  " Last to override any settings
  Plug 'editorconfig/editorconfig-vim'
endif

Plug 'flazz/vim-colorschemes'
Plug 'christoomey/vim-tmux-navigator'

" ???
"Plug 'tpope/vim-sexp-mappings-for-regular-people'
"Plug 'guns/vim-sexp'

call plug#end()
