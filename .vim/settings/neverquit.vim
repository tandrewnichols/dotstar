" Don't allow quitting vim with JUST q (type quit or wq).
" Learn to stay in vim for more things.
cnoreabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

function! s:ToggleNeverQuit(disable)
  redir => abbrevs
  try
    silent! cabbrev q
  catch *

  endtry
  redir END

  if a:disable
    try
      cunabbrev q
    catch *
      " No-op, abbreviation already didn't exist
    endtry
    return
  endif

  if abbrevs =~ 'No abbreviation found'
    cnoreabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
  else
    cunabbrev q
  endif
endfunction

command! -nargs=0 -bang Neverquit call s:ToggleNeverQuit(<bang>0)
