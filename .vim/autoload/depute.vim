let s:mappingchars = ['.', ';', '(', '<Space>']

function! depute#inject(fn)
  exec "imap \<buffer> \<Esc> \<C-c>'':iunmap <buffer> <ESC>\<CR>" 
  exec "call depute#inject#" . a:fn . "()"
  startinsert
  normal! l
endfunction

function! depute#unmapChars()
  for char in s:mappingchars
    silent! exec "iunmap \<buffer> " . char
  endfor

  iunmap <buffer> <Esc>
endfunction

function! s:MapChar(char, handler, after) abort
  silent! exec "inoremap \<buffer> " . a:char . " \<Esc>\"dyiwe:call depute#inject#" . a:handler . "()\<CR>" . a:after . "`':call depute#unmapChars()\<CR>a" . a:char
endfunction

function! depute#mapChars(fn, after)
  for char in s:mappingchars
    call s:MapChar(char, a:fn, a:after)
  endfor

  inoremap <buffer> <Esc> <Esc>:call depute#unmapChars()<CR>
endfunction

function! depute#autoInject(fn, after)
  let base = "\<Esc>:call depute#mapChars('" . a:fn . "', '" . a:after . "')\<CR>"
  echom base
  if getline('.') =~ '^\s*$'
    return base . "cc"
  else
    return base . "a"
  endif
endfunction

