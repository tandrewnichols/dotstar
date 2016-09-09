" Bundles
set nocp
let g:isMac = substitute(system('uname'), "\n", "", "") == "Darwin"
let $BASH_ENV = "~/.bash_aliases"
source ~/.vim/plugins.vim

filetype plugin indent on 
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:instant_markdown_slow = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:mocha_js_command = "!mocha --reporter spec {spec}"

if !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
endif
set undodir=~/.vim/backups
set undofile
set foldmethod=marker
set foldlevelstart=20
set t_Co=256
colorscheme jellybeans
syntax enable
set tabstop=2 shiftwidth=2 expandtab
set tw=0
set number
set nohlsearch
hi MatchParen cterm=bold ctermbg=none ctermfg=red
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
set wildmode=longest:full,full
set autoread
set history=1000
set tabpagemax=50
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.json setf javascript
  autocmd BufNewFile,BufRead *.es6 setf javascript
  autocmd BufNewFile,BufRead *.jsx setf javascript
  autocmd BufNewFile,BufRead *.less setf less
  autocmd BufNewFile,BufRead *.ejs setf html
  autocmd BufNewFile,BufRead *.hbs setf html
  autocmd BufNewFile,BufRead *.mustache setf html
augroup END
set scrolloff=3
set sidescrolloff=15
set sidescroll=1
set ignorecase
set smartcase
set nobackup
set backupcopy=yes
set linebreak
set noswapfile
set mouse=a
set noshowmode
set diffopt=filler,vertical,iwhite
set timeoutlen=500
if &term =~ '256color'
  set t_ut=
endif
autocmd BufEnter * set nocindent
set showbreak=>>\ \ \ \ 

" Load everything in settings
let vimsettings = '~/.vim/settings'
for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  if (fpath == expand(vimsettings) . "/mac.vim") && !g:isMac
    continue " skip mac mappings for linux
  endif

  if (fpath == expand(vimsettings) . "/linux.vim") && g:isMac
    continue " skip linux mappings for mac
  endif

  exe 'source ' . fpath
endfor
