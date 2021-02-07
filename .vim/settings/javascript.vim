function! s:DoAction(name) abort
  let name = a:name
  let constant = toupper(substitute(name, '\(\l\)\(\u\)', '\1\_\l\2', ""))
  let lines = [
    \   "export const " . name . " = createAction('" . constant . "');",
    \   "export const " . name . "Success = createAction('" . constant . "_SUCCESS');",
    \   "export const " . name . "Error = createAction('" . constant . "_ERROR');"
    \ ]

  let block = join(lines, "\n")

  put =block
endfunction

function! CreateAction() abort
  command! -buffer -nargs=1 Action call s:DoAction(<f-args>)
endfunction

augroup redux
  au!
  au FileType javascript call CreateAction()
augroup END
