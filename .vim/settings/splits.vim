nnoremap <leader><right> <C-w>J
nnoremap <leader><down> <C-w>L
nnoremap <leader><up> <C-w>K
nnoremap <leader><left> <C-w>H
nnoremap <leader>T <C-w>T
nnoremap <leader>= :let g:curbuf = bufnr('%')<CR>:bun<CR>

function! s:OpenCurBuf(cmd)
  if exists("g:curbuf")
    exec a:cmd g:curbuf
    unlet g:curbuf
  endif
endfunction

nnoremap <leader>V :call <sid>OpenCurBuf('vert sb')<CR>
nnoremap <leader>H :call <sid>OpenCurBuf('sb')<CR>
