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

nnoremap <leader>y :YRShow<CR>
