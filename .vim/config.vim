" Other configuration
set foldmethod=marker
set foldlevelstart=0
set t_Co=256
colorscheme jellybeans
filetype plugin indent on
syntax enable
set tabstop=2 shiftwidth=2 expandtab
set number
set nohlsearch
set nowrap
set splitbelow
set splitright
set autoindent
set smartindent
set backspace=indent,eol,start
set hidden
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set incsearch
set showmatch
set shiftround
set wildmenu
set autoread
set history=1000
set tabpagemax=50
au BufNewFile,BufRead *.json setf javascript
au BufNewFile,BufRead *.less setf less
au BufNewFile,BufRead *.ejs setf html
au BufNewFile,BufRead *.hbs setf html
set scrolloff=3
set ignorecase
set smartcase
set nobackup
set backupcopy=yes
set linebreak
set noswapfile
set mouse=a
if &term =~ '256color'
  set t_ut=
endif
autocmd BufEnter * set nocindent
set showbreak=>>\ \ \ \ 

if expand('%:p') =~ 'manta-frontend/client'
  "TODO add directory specific snippet loading
endif
