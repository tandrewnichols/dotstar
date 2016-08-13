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
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Reverse go to mark bindings
nnoremap ' `
nnoremap ` '

" Remap C-a so tmux can use C-a
map <C-b> <C-a>

" Always navigate line-wise
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Make Y yank to end of line (and still work with yankring)
function! YRRunAfterMaps()
  nnoremap Y :<C-U>YRYankCount 'y$'<CR>
endfunction
