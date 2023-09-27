call plug#begin()

if !exists('g:bones')
  Plug 'tmhedberg/matchit'
  Plug 'MarcWeber/vim-addon-mw-utils'

  " Tim Pope plugins
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  " Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-heroku'
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'tandrewnichols/vim-projectionist', { 'branch': 'patch-1' }
  " Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-ragtag'
  " Plug 'tpope/vim-classpath'

  Plug 'vim-utils/vim-husk'

  " Filetype plugins
  " Plug 'amadeus/vim-jsx'
  Plug 'maxmellon/vim-jsx-pretty'
  " Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
  Plug 'ap/vim-css-color'
  Plug 'lunaru/vim-less'
  " Plug 'digitaltoad/vim-jade'
  Plug 'kchmck/vim-coffee-script'
  Plug 'stephpy/vim-yaml'
  Plug 'fatih/vim-go'
  Plug 'leafgarland/typescript-vim'
  Plug 'othree/csscomplete.vim'
  Plug 'rhysd/vim-gfm-syntax'
  Plug 'othree/html5.vim'
  Plug 'ElmCast/elm-vim'
  Plug 'jidn/vim-dbml'
  Plug 'jparise/vim-graphql'
  Plug 'neo4j-contrib/cypher-vim-syntax'
  Plug 'hashivim/vim-terraform'

  " Functionality plugins
  Plug 'tomtom/tcomment_vim'
  Plug 'tomtom/tlib_vim'
  Plug 'mbbill/undotree'
  Plug 'dense-analysis/ale'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'tandrewnichols/closetag.vim'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install tern-grunt tern-gulp tern-jasmine tern-jsx' }
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'kshenoy/vim-signature'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'milkypostman/vim-togglelist'
  Plug 'machakann/vim-swap'
  Plug 'unblevable/quick-scope'
  Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
  Plug 'dbakker/vim-projectroot'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-scripts/YankRing.vim'
  Plug 'terryma/vim-expand-region'
  Plug 'edkolev/vim-amake'

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

  Plug 'kana/vim-submode'
  Plug 'skwp/greplace.vim'
  Plug 'AndrewRadev/switch.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'thinca/vim-visualstar'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'vim-scripts/genutils'
  Plug 'godlygeek/tabular'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ervandew/supertab'
  Plug 'SirVer/ultisnips'
  Plug 'artnez/vim-wipeout'
  Plug 'bkad/camelcasemotion'
  Plug 'junegunn/vim-emoji'
  Plug 'junegunn/vader.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-peekaboo'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'wellle/visual-split.vim'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-reload'
  Plug 'AaronLasseigne/yank-code'
  Plug 'matze/vim-move'
  Plug 'markonm/traces.vim'
  Plug 'rhysd/git-messenger.vim'
  Plug 'neowit/vim-force.com'
  Plug 'dyng/ctrlsf.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'umaumax/vim-lcov'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  Plug 'lambdalisue/fern-bookmark.vim'
  Plug 'lambdalisue/fern-mapping-git.vim'
  Plug 'lambdalisue/fern-mapping-project-top.vim'
  Plug 'lambdalisue/fern-mapping-quickfix.vim'
  Plug 'andykog/fern-copynode.vim'

  " Local plugins
  Plug '~/code/anichols/vim/vim-vigor'
  Plug '~/code/anichols/vim/vim-rumrunner'
  Plug '~/code/anichols/vim/vim-rebuff'
  Plug '~/code/anichols/vim/vim-girlfriend'
  Plug '~/code/anichols/vim/vim-determined'
  Plug '~/code/anichols/vim/vim-whelp'
  Plug '~/code/anichols/vim/vim-headfirst'
  Plug '~/code/anichols/vim/vim-docile'
  Plug '~/code/anichols/vim/vim-tapir'
  Plug '~/code/anichols/vim/vim-replete'
  Plug '~/code/anichols/vim/vim-contemplate'
  Plug '~/code/anichols/vim/vim-dadbod-extensions'
  Plug '~/code/anichols/vim/vim-textobj-keyvalue-pair'
  Plug '~/code/anichols/forks/javascript-libraries-syntax.vim'

  " Last to override any settings
  Plug 'editorconfig/editorconfig-vim'
endif

Plug 'flazz/vim-colorschemes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'pangloss/vim-javascript'

call plug#end()
