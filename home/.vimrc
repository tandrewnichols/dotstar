" Bundles
set nocp
set shell=/bin/bash
let g:isMac = substitute(system('uname'), "\n", "", "") == "Darwin"
let $BASH_ENV = "~/.bash_aliases"
let shell=trim(system("which bash"))
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/UltiSnips']
let g:UltiSnipsEnableSnipMate=0

if !exists('g:noplugins')
  source ~/.vim/plugins.vim
endif

filetype plugin indent on 
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

if !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
endif
set undodir=~/.vim/backups
set undofile
set foldlevelstart=99
set t_Co=256
if !exists('g:noplugins')
  let g:jellybeans_background_color_256='NONE'
  colorscheme jellybeans
endif
syntax enable
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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
set wildmode=full
" set wildmode=longest:full,full
set wildignore=package-lock.json
set autoread
set history=1000
set tabpagemax=50
set completeopt-=preview
set encoding=UTF-8

augroup filetypes
  au!
  au BufNewFile,BufRead *.es6,*.jsx :set ft=javascript.jsx
  au BufNewFile,BufRead *.tsx :set ft=typescript.tsx
  au BufNewFile,BufRead *.less :set ft=less
  au BufNewFile,BufRead *.ejs,*.hbs,*.mustache :set ft=html
  au BufNewFile,BufRead *.md,*.mdx :set ft=markdown
  au BufNewFile,BufRead *.html,*.js,*.ejs,*.hbs,*.mustache let b:unaryTagsStack = "area base br dd dt hr img input link meta param"
  au BufNewFile,BufRead *.apex :set ft=apexcode
  au BufNewFile,BufRead *.lss :set ft=xml
  au BufNewFile,BufRead *.asc :set ft=json
  au FileType jsx let b:unaryTagsStack = ""
  au FileType javascriptreact :set ft=javascript.jsx
  au FileType typescriptreact :set ft=typescript.tsx
  au FileType html,css setlocal isk+=45
  au FileType css,less setlocal omnifunc=csscomplete#CompleteCSS
  au FileType netrw setlocal bufhidden=delete
  au Filetype elm setlocal tabstop=4 shiftwidth=4
  au Filetype java,go,php setlocal noexpandtab
augroup END

augroup startup
  au!
  au StdinReadPost * :set buftype=nofile
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
set cursorline
set ttyfast
set lazyredraw

set isf+=[,],(,),@-@

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
