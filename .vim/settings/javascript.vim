function! s:DoAction(name) abort
  let name = a:name
  let constant = toupper(substitute(name, '\(\l\)\(\u\)', '\1\_\l\2', "g"))
  let lines = [
    \   "export const " . name . " = createAction('" . constant . "');",
    \   "export const " . name . "Success = createAction('" . constant . "_SUCCESS');",
    \   "export const " . name . "Error = createAction('" . constant . "_ERROR');"
    \ ]

  let block = join(lines, "\n")

  put =block
endfunction

function! s:SearchForActionName(name) abort
  if exists("a:name") && len(a:name)
    silent! exec "normal /" . a:name . "<CR>"
  endif
endfunction

function! s:AddCloseAbbrev() abort
  command! -buffer -nargs=0 Q tabclose
  cabbrev <buffer> q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Q' : 'q')<CR>
endfunction

function! s:ViewAction(name) abort
  let file = a:name
  " let [file, action] = split(a:name, '\.')
  let cwd = getcwd()
  let root = stridx(cwd, "/src") > -1 ? cwd : cwd . "/src"

  exec "tabe " . root . "/hooks/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  let left = winnr()

  exec "vsp " . root . "/store/effects/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  exec "sp " . root . "/store/actions/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  exec "sp " . root . "/store/selectors/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)

  exec left . "wincmd w"

  exec "sp " . root . "/store/reducers/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)

  " set hls
endfunction

function! CreateAction() abort
  command! -buffer -nargs=1 Action call s:DoAction(<f-args>)
  command! -buffer -nargs=1 ViewAction call s:ViewAction(<f-args>)
endfunction

augroup redux
  au!
  au FileType javascript call CreateAction()
augroup END

nnoremap <leader>j :Jest<CR>
