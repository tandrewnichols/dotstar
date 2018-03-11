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
    if stridx(arg, '.') > -1 && filereadable(expand('%:h/') . '/' .arg)
      exec a:cmd "%:h/" . arg
    elseif filereadable(expand("%:h/"). '/' . arg . extension)
      exec a:cmd "%:h/" . arg . extension
    endif
  endfor
endfunction

function! HeadLineCustomComplete(lead, ...)
  let dir = expand("%:h")

  if !empty(a:lead) && stridx(a:lead, '\/') > -1
    let dir .= '/' . join(split(a:lead, '\/')[0:-2], '/')
  endif

  let files = glob(dir . '/*', 0, 1)

  let maybedir = dir . '/' . a:lead
  if !empty(a:lead) && index(files, maybedir) > -1 && isdirectory(a:lead)
    let files = glob(maybedir . '/*', 0, 1)
  endif

  let heads = map(map(files, 'split(v:val, "\/")[-1]'), 'isdirectory(v:val) ? v:val . "/" : v:val')

  return join(heads, "\n")
endfunction

" TODO: file completion is not quite right. Need to do something custom.
command! -nargs=+ -complete=custom,HeadLineCustomComplete Hedit call s:OpenFromSameDir('e', <f-args>)
command! -nargs=+ -complete=custom,HeadLineCustomComplete HSplit call s:OpenFromSameDir('sp', <f-args>)
command! -nargs=+ -complete=custom,HeadLineCustomComplete HVSplit call s:OpenFromSameDir('vsp', <f-args>)
command! -nargs=+ -complete=custom,HeadLineCustomComplete HTabe call s:OpenFromSameDir('tabe', <f-args>)
