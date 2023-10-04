if !empty(glob('~/.vim/dbs.vim'))
  source ~/.vim/dbs.vim
endif

let g:db_ui_auto_execute_table_helpers = 1
let g:db_ui_save_location = '~/.vim/db-ui'
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_execute_on_save = 0

function! s:SetupDbUiMaps() abort
  vmap <buffer> <CR> <Plug>(DBUI_ExecuteQuery)
  nmap <buffer> <CR> :exec "normal \<s-v> \<Plug>(DBUI_ExecuteQuery)"<CR>
endfunction

augroup DBQueries
  au!
  au Filetype mysql call <sid>SetupDbUiMaps()
  au BufNew *.dbout nnoremap <buffer> gt f<bar>w
  au BufNew *.dbout nnoremap <buffer> gT :call s:PrevCell()<CR>
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
