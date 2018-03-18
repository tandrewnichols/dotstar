function! s:Tweet(...)
  silent call system('tweet ' . shellescape(join(a:000, ' ')))
endfunction
command! -nargs=* Tweet :call s:Tweet('<args>')
