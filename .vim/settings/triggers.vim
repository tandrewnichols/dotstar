function! s:Trigger(cmd) abort
  exec "au triggers BufWritePost <buffer>" a:cmd
endfunction

command! -nargs=+ -complete=command Trigger call <SID>Trigger(<q-args>)
