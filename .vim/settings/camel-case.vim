let s:ignoreWords = ['is', 'of', 'a', 'an', 'the', 'to']
function! s:Titleize(what)
  let newWords = []
  let curWords = split(a:what, ' ')
  for word in curWords
    if word == curWords[0] || index(s:ignoreWords, word) == -1
      call add(newWords, substitute(word, '\v^([a-z])(.*)', '\u\1\2', ''))
    else
      call add(newWords, word)
    endif
  endfor

  return join(newWords, ' ')
endfunction

function! s:TitleizeInsideSingle()
  normal! "adi'
  let @b = <SID>Titleize(@a)
  normal! h"bp
endfunction

function! s:TitleizeInsideDouble()
  normal! "adi"
  let @b = <SID>Titleize(@a)
  normal! h"bp
endfunction

function! s:TitleizeInsideCurrentString()
  normal! mt
  normal! "ayi"
  normal! 't
  normal! "byi'
  normal! 't
  if len(@a) > len(@b)
    call <SID>TitleizeInsideSingle()
  else
    call <SID>TitleizeInsideDouble()
  endif
  normal! dmt
endfunction

nnoremap <leader>c' :call <SID>TitleizeInsideSingle()<CR>
nnoremap <leader>c" :call <SID>TitleizeInsideDouble()<CR>

command! -nargs=0 Titleize :call <SID>TitleizeInsideCurrentString()<CR>
