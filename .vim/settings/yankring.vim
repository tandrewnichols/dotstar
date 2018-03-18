" Don't capture single letters
let g:yankring_min_element_length = 2

" Egh . . . yankring gets in the way of repeating
" vim-surround motions, like ds'. Not sure yet
" what other ramifications this will have.
let g:yankring_map_dot = 0

" Use vertical split
let g:yankring_window_use_horiz = 0

" Vertical split width
let g:yankring_window_width = 60

" Space increments width by 40. Another resets.
let g:yankring_window_increment = 40

" Put yankring history in .vim folder
let g:yankring_history_dir = '$HOME/.vim'

" Don't map gp and gP
let g:yankring_paste_using_g = 0

nnoremap <leader>y :YRShow<CR>

" Make Y yank to end of line (and still work with yankring)
function! YRRunAfterMaps()
  nnoremap Y :<C-U>YRYankCount 'y$'<CR>
  " Overwrite ib and ab to mean paragraph in order to
  " free up p to mean previous for targets.vim
  xnoremap ab ap
  onoremap ab ap
  xnoremap ib ip
  onoremap ib ip
endfunction
