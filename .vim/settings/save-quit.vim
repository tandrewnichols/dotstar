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
