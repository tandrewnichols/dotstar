let g:netrw_banner=1
nnoremap <leader>- :bd<CR>

function! s:NonNetrwMappings()
  nnoremap <Bar> :Vexplore<CR>
  nnoremap <buffer> <leader>+ :Texplore<CR>
endfunction

function! s:OpenInBackground()
  let winid = win_getid()
  let pos = getpos('.')
  normal t
  call win_gotoid(winid)
  call setpos('.', pos)
endfunction

function! s:MakeNetrwMappings()
  if !exists("b:netrw_background_t_mapped")
    nnoremap <buffer> T :call <sid>OpenInBackground()<CR>
  endif
  let b:netrw_background_t_mapped = 1
endfunction

augroup NetrwMappings
  au!
  au BufEnter * if &ft != 'netrw' | call <sid>NonNetrwMappings() | endif
  au FileType netrw call <sid>MakeNetrwMappings()
augroup END
