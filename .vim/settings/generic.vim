function! s:Fix() abort
  set cmdheight=1
  normal <C-w>_
endfunction
command Fix -nargs=0 call <SID>Fix()
