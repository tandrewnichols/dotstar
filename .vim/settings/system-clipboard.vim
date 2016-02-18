function! s:SystemClipboard(type, let)
  let reg="+"
  if g:isMac
    let reg="*"
  endif
  if a:type == "char"
    silent exe 'norm! v`[o`]"' . reg . a:let
  elseif a:type == "line"
    silent exe 'norm! `[V`]"' .reg . a:let
  endif
endfunction

function! s:yOpfunc(type)
  :call s:SystemClipboard(a:type, 'y')
endfunction

function! s:dOpfunc(type)
  :call s:SystemClipboard(a:type, 'd')
endfunction

function! s:sOpfunc(type)
  :call s:SystemClipboard(a:type, 's')
endfunction

function! s:cOpfunc(type)
  :call s:SystemClipboard(a:type, 'c')
endfunction

nnoremap <silent> <leader>;y :set opfunc=<SID>yOpfunc<CR>g@
nnoremap <silent> <leader>;d :set opfunc=<SID>dOpfunc<CR>g@
nnoremap <silent> <leader>;s :set opfunc=<SID>sOpfunc<CR>g@
nnoremap <silent> <leader>;c :set opfunc=<SID>cOpfunc<CR>g@

if g:isMac
  nnoremap <leader>;p "*p
  nnoremap <leader>;P "*P
  nnoremap <leader>;x "*x
  nnoremap <leader>;X "*X
  vnoremap <leader>;p "*p
  vnoremap <leader>;P "*P
  vnoremap <leader>;y "*y
  vnoremap <leader>;c "*c
  vnoremap <leader>;d "*d
  vnoremap <leader>;x "*x
  vnoremap <leader>;s "*s
  vnoremap <leader>;r "*r
  nnoremap <leader>;Y "*Y
else
  nnoremap <leader>;p "+p
  nnoremap <leader>;P "+P
  nnoremap <leader>;x "+x
  nnoremap <leader>;X "+X
  vnoremap <leader>;p "+p
  vnoremap <leader>;P "+P
  vnoremap <leader>;y "+y
  vnoremap <leader>;c "+c
  vnoremap <leader>;d "+d
  vnoremap <leader>;x "+x
  vnoremap <leader>;s "+s
  vnoremap <leader>;r "+r
  nnoremap <leader>;Y "+Y
endif
