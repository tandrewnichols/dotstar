" ------
" SEARCH
" ------

" Turn off highlighting
nnoremap <silent> <leader><Esc> :set nohlsearch<Bar>:echo<CR>

" Highlight matches
nnoremap <silent> <leader><CR> :set hls<CR>

" Center next match on screen
"nnoremap <silent> <F2> nzz

" Remove-lines: remove all lines matching pattern
nnoremap <silent> <leader>rl :exec ":g/".input("Remove lines matching: ")."/d"<CR>

" Grep for word under cursor
nnoremap <leader>gr :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" ---------
" SAVE/QUIT
" ---------

" Save in insert mode and reenter insert mode
inoremap <C-s> <Esc>:w<CR>a

" Save in normal mode
nnoremap <C-s> :w<CR>

" Quit in insert mode without saving
inoremap <C-q> <Esc>:q!<CR>

" Quit in normal mode without saving
nnoremap <C-q> :q!<CR>


" ----
" TABS
" ----

" Go to next tab
nnoremap <Tab> gt

" Go to previous tab
nnoremap <S-Tab> gT


" ----------------
" SWITCH MODES
" ----------------

" Delete previous char and enter insert mode
nnoremap <BS> i<BS>

" Delete current char and enter insert mode
nnoremap <Del> a<BS>


" ---------------------
" REAMP ANNOYING THINGS
" ---------------------

" Remap F1
map <F1> <Esc>
imap <F1> <Esc>
nnoremap Y y$
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" Source vimrc
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>


" ---------------
" GENERIC HELPERS
" ---------------

" Yank inside quotes to system clipboard (Linux only)
nnoremap <leader>yi" F'lvf'h"+y

" Blank line below and stay in normal mode
nnoremap <leader>oj o<Esc>

" Blank line above and stay in normal mode
nnoremap <leader>ok O<Esc>

" Clear line and stay in normal
nnoremap <leader>rm cc<Esc>

" Reverse go to mark bindings
nnoremap ' `
nnoremap <leader>' '

" Turn on wrapping
nnoremap <leader>wr :set wrap<CR>

" Turn off wrapping
nnoremap <leader>nw :set nowrap<CR>

" Go to previous error
nnoremap <silent> <leader>[ :lp<CR>zz

" Go to next error
nnoremap <silent> <leader>] :lne<CR>zz

" Remap C-a so tmux can use C-a
map <C-b> <C-a>

" Easy escape from insert mode
inoremap <silent> jkl <Esc>

" Always navigate line-wise
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Underline the current line with dashes/equals in normal mode
nnoremap <leader>-- yyp<c-v>$r-
nnoremap <leader>== yyp<c-v>$r=

" Change .json to two space indents
nnoremap <leader>json ggdG:r ! node -e "console.log(JSON.stringify(require('%'), null, 2))"<CR>

" Open an angular template under cursor
nnoremap <leader>ng :let myfile=expand("<cfile>")<CR>:execute("tabe ".projectroot#guess()."/client/app/templates/".myfile)<CR>


" -------------
" JASMINE/MOCHA
" -------------

" Top-only: Add .only to top-most describe
nnoremap <silent> <leader>to moG/describe<CR>ea.only<Esc>`o:delmarks o<CR>

" Describe-only: Add .only to nearest describe
nnoremap <silent> <leader>do mo/describe<CR><S-N>ea.only<Esc>`o:delmarks o<CR>

" Context-only: Add .only to nearest context
nnoremap <silent> <leader>co mo/context<CR><S-N>ea.only<Esc>`o:delmarks o<CR>
 
" Remove-only: Remove all occurrences of .only
nnoremap <silent> <leader>ro mo:%s/\.only//g<CR>`o:delmarks o<CR>

" xdescribe: xdescribe nearest describe
nnoremap <silent> <leader>dx ms/describe<CR><S-N>ix<Esc>'s:delmarks s<CR>

" Context-skip: xcontext nearest context
nnoremap <silent> <leader>cx ms/context<CR><S-N>ix<Esc>'s:delmarks s<CR>

" Remove x: Replace xdescribe with describe and xcontext with context
nnoremap <silent> <leader>rx ms:%s/x\(describe\\|context\)/\1/g<CR>`s:delmarks s<CR>


" -------
" BUFFERS
" -------

" List buffers
nnoremap <leader>ls :ls<CR>

" Previous buffer
nnoremap <leader>bp :bp<CR>

" Next buffer
nnoremap <leader>bn :bn<CR>

" Most recent buffer
nnoremap <leader>ge :e#<CR>

" Numbered buffers
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :8b<CR>
nnoremap <leader>0 :10b<CR>


" -------------
" MISCELLANEOUS
" -------------

" Open file under cursor in new tab
nnoremap K <C-w>gf
