" Bundles
set nocp
let g:isMac = substitute(system('uname'), "\n", "", "") == "Darwin"
let $BASH_ENV = "~/.bash_aliases"

if !exists('g:noplugins')
  source ~/.vim/plugins.vim
endif

filetype plugin indent on 
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:instant_markdown_slow = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

if !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
endif
set undodir=~/.vim/backups
set undofile
set foldlevelstart=99
set t_Co=256
if !exists('g:noplugins')
  colorscheme jellybeans
endif
syntax enable
set tabstop=2 shiftwidth=2 expandtab
set tw=0
set number
set nohlsearch
hi MatchParen cterm=bold ctermbg=none ctermfg=red
set fo+=j
set nowrap
set splitbelow
set splitright
set backspace=indent,eol,start
set hidden
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set incsearch
set showmatch
set shiftround
set wildmenu
set wildmode=longest,full
" set wildmode=longest:full,full
set autoread
set history=1000
set tabpagemax=50
set completeopt-=preview
augroup filetypes
  au!
  au BufNewFile,BufRead *.json,*.es6,*.jsx setf javascript
  au BufNewFile,BufRead *.less setf less
  au BufNewFile,BufRead *.ejs,*.hbs,*.mustache setf html
  au BufNewFile,BufRead *.md setf markdown
  au BufNewFile,BufRead *.html,*.js,*.jsx,*.ejs,*.hbs,*.mustache let b:unaryTagsStack = "area base br dd dt hr img input link meta param"
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType less setlocal omnifunc=csscomplete#CompleteCSS
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
set nocursorline
set ttyfast
set lazyredraw

if &term =~ '256color'
  set t_ut=
endif
autocmd BufEnter * set nocindent
set showbreak=>>\ \ \ \ 

" Directory-specific settings use:
" autocmd BufNewFile,BufRead /path/to/files/* set nowrap tabstop=4 shiftwidth=4
" e.g.
"   autocmd BufNewFile,BufRead */manta-frontend/client* setlocal path+=,app/templates
if !exists('g:noplugins') && !exists('g:bones')
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
endif
