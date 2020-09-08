if glob("$HOME/.vim/db-connections.vim")
  source $HOME/.vim/db-connections.vim
endif

let g:db_ui_auto_execute_table_helpers = 1
let g:db_ui_save_location = '~/.vim/db-ui'

augroup DBQueries
  au!
  au FileType sql nmap <expr> <CR> db#op_exec()
  au FileType sql xmap <expr> <CR> db#op_exec()
  au BufNew *.dbout nnoremap <buffer> gt f<bar>w
  au BufNew *.dbout nnoremap <buffer> gT :call s:PrevCall()<CR>
augroup END

function! s:PrevCell() abort
  normal F|
  let [a, b, col, c] = getpos('.')
  normal F|
  let [a2, b2, newcol, c2] = getpos('.')

  if col == newcol
    normal 0w
  else
    normal w
  endif
endfunction

" nmap <expr> <C-Q> db#op_exec()
" xmap <expr> <C-Q> db#op_exec()
