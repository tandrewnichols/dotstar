function! IsInGitProject(dirname)
  return RootDirName() ==? a:dirname
endfunction

function! IsInDirectory(name)
  return matchstr(getcwd(), a:name)
endfunction

function! CdToDirectory(loc)
  echo "Changing directory to ". a:loc
  execute "silent :cd ".projectroot#guess()."/".a:loc
endfunction

function! DoIfMantaFrontend(command)
  if RootDirName() ==? 'manta-frontend'
    silent execute a:command
  endif
endfunction

augroup MfCdCommands
  autocmd BufCreate * call DoIfMantaFrontend("silent nnoremap <buffer> <leader>cdc :call CdToDirectory('client')<CR>")
  autocmd BufCreate * call DoIfMantaFrontend("silent nnoremap <buffer> <leader>cds :call CdToDirectory('server')<CR>")
  autocmd BufCreate * call DoIfMantaFrontend("silent nnoremap <buffer> <leader>cdt :call CdToDirectory('tasks')<CR>")
augroup END
