function! s:XMLFormat() abort
  !tidy -mi -xml -wrap 0 %
endfunction

command! -nargs=0 XMLFormat call s:XMLFormat()
