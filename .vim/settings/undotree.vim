let g:undotree_SetFocusWhenToggle = 1

" Open Gundo undo tree
nnoremap <silent> <leader>un :UndotreeToggle<CR>

function! g:Undotree_CustomMap()
  nmap <buffer> j J
  nmap <buffer> k K
  nmap <buffer> <CR> :UndotreeToggle<CR>
endfunction
