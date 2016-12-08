augroup indenting
  au!
  au BufNewFile,BufRead * call MaybeSetIndenting()
augroup END

function! MaybeSetIndenting()
  if &ft !~ 'javascript'
    setlocal autoindent
    setlocal smartindent
  endif
endfunction
