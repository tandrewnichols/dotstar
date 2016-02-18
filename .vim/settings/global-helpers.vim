" getchar returns a number code, so convert that to a letter
function! GetRealChar()
  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction

" Get a char from the user, but return nothing for Esc and Ctrl-C
function! GetUserInput()
  let c = GetRealChar()
  if c == " "
    let c .= GetRealChar()
  endif
  if c =~ "\<Esc>" || c =~ "\<C-C>"
    return ""
  else
    return c
  endif
endfunction
