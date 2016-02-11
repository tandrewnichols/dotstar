" Used for NERDCommenterInvert, which I never use and interferes with
" <leader>ciw for cutting a word to the system clipboard.
if hasmapto("<Plug>NERDCommenterInvert")
  nunmap <leader>ci
  xunmap <leader>ci
endif

function! s:SystemClipboard(type, let)
  let reg="+"
  if g:osName == 'Darwin'
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

nnoremap <silent> <leader>y :set opfunc=<SID>yOpfunc<CR>g@
nnoremap <silent> <leader>d :set opfunc=<SID>dOpfunc<CR>g@
nnoremap <silent> <leader>s :set opfunc=<SID>sOpfunc<CR>g@
nnoremap <silent> <leader>c :set opfunc=<SID>cOpfunc<CR>g@

if g:osName == 'Darwin'
  nnoremap <leader>p "*p
  nnoremap <leader>P "*P
  nnoremap <leader>x "*x
  nnoremap <leader>X "*X
  vnoremap <leader>p "*p
  vnoremap <leader>P "*P
  vnoremap <leader>y "*y
  vnoremap <leader>c "*c
  vnoremap <leader>d "*d
  vnoremap <leader>x "*x
  vnoremap <leader>s "*s
  vnoremap <leader>r "*r
else
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P
  nnoremap <leader>x "+x
  nnoremap <leader>X "+X
  vnoremap <leader>p "+p
  vnoremap <leader>P "+P
  vnoremap <leader>y "+y
  vnoremap <leader>c "+c
  vnoremap <leader>d "+d
  vnoremap <leader>x "+x
  vnoremap <leader>s "+s
  vnoremap <leader>r "+r
endif
