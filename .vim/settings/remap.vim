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

" Reverse go to mark bindings
nnoremap ' `
nnoremap <leader>' '

" Remap C-a so tmux can use C-a
map <C-b> <C-a>

" Open file under cursor in new tab
nnoremap K <C-w>gf

" Always navigate line-wise
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy escape from insert mode
inoremap <silent> jj <Esc>
