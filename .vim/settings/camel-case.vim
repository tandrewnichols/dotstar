let s:ignoreWords = ['is', 'of', 'a', 'an', 'the', 'to']
function! Titleize(what)
  let newWords = []
  for word in split(a:what, ' ')
    if index(s:ignoreWords, word) == -1
      call add(newWords, substitute(word, '\v^([a-z])(.*)', '\u\1\2', ''))
    else
      call add(newWords, word)
    endif
  endfor

  return join(newWords, ' ')
endfunction

function! s:TitleizeInsideSingle()
  normal! "adi'
  let @b = Titleize(@a)
  normal! h"bp
endfunction

function! s:TitleizeInsideDouble()
  normal! "adi"
  let @b = Titleize(@a)
  normal! h"bp
endfunction

nnoremap <leader>c' :call <SID>TitleizeInsideSingle()<CR>
nnoremap <leader>c" :call <SID>TitleizeInsideDouble()<CR>
