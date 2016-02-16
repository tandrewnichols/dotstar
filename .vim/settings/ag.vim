if exists("g:loaded_vim_ag_anything") || &cp || v:version < 700
  finish
endif
let g:loaded_vim_ag_anything = 1

function! s:Ag(type,...) abort
  if a:type !=# "char"
    return
  endif

  let reg_save = @@

  " copy selected text to @@ register
  silent exe "normal! `[v`]y"
  exe ":let @/='" . @@ . "'"
  exe ':Ag "' . @@ . '"'
  normal! n

  let @@ = reg_save
endfunction

" NOTE: set hlsearch does not work in a function
nnoremap <silent> <Plug>AgAnything     :set hlsearch<CR>:<C-U>set opfunc=<SID>Ag<CR>g@
nmap gag <Plug>AgAnything

nnoremap <leader>ag :Ag 
