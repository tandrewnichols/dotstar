let s:mappingchars = ['.', ';', '(', '<Space>']

function! s:GoToInjectionPoint()
  call search('angular.module', 'sw')
  normal! $F)i, 
endfunction

function! s:DirectInject()
  function! s:FinishUnmap()
    iunmap <buffer> <Esc>
    startinsert
    normal! ll
  endfunction

  exec "imap \<buffer> \<Esc> \<C-c>'':call \<SID>FinishUnmap()\<CR>" 
  call <SID>GoToInjectionPoint()
  startinsert
  normal! l
endfunction

nnoremap <leader>di :call <SID>DirectInject()<CR>

function! s:UnmapAllChars()
  for char in s:mappingchars
    silent! exec "iunmap \<buffer> " . char
  endfor

  iunmap <buffer> <Esc>
endfunction

function! s:AutoDirectInject()
  for char in s:mappingchars
    silent! exec "inoremap \<buffer> " . char . " \<Esc>\"dyiwe:call \<SID>GoToInjectionPoint()\<CR>\<Esc>\"dp`':call <SID>UnmapAllChars()\<CR>a" . char
  endfor

  inoremap <buffer> <Esc> <Esc>:call <SID>UnmapAllChars()<CR>
endfunction

inoremap <C-j>di <Esc>:call <SID>AutoDirectInject()<CR>a
