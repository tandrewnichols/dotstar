let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Open nerd tree relative to current buffer
nnoremap <silent> <leader>ntb :exe ":NERDTree ".expand("%:h")<CR>
" ntf = nerd tree find
nnoremap <silent> <leader>ntf :NERDTreeFind<CR>
" ntp = nerd tree present
nnoremap <silent> <leader>ntp :NERDTree<CR>
