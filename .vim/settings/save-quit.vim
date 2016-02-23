" ---------
" SAVE/QUIT
" ---------

" Save in insert mode and reenter insert mode
inoremap <C-s> <Esc>:w<CR>a

" Quit in insert mode without saving
inoremap <C-q> <Esc>:q!<CR>

" Quit in normal mode without saving
nnoremap <C-q> :q!<CR>
