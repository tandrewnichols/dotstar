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

function! s:OpenFromSameDir(cmd, ...) abort
  let extension = '.' . expand('%:e')
  for arg in a:000
    if filereadable(expand("%:h/"). '/' . arg . extension)
      exec a:cmd "%:h/" . arg . extension
    endif
  endfor
endfunction

command! -nargs=+ Hedit call s:OpenFromSameDir('e', <f-args>)
command! -nargs=+ HSplit call s:OpenFromSameDir('sp', <f-args>)
command! -nargs=+ HVSplit call s:OpenFromSameDir('vsp', <f-args>)
command! -nargs=+ HTabe call s:OpenFromSameDir('tabe', <f-args>)
