function! s:RunNpmCss() abort
  let cwd = getcwd()
  cd ~/code/anichols/manta/fe-directory
  Npm run css
  exec "cd" cwd
endfunction

augroup triggers
  au!
  au BufWritePost */fe-directory/*.css,*/fe-directory/*/tailwind.config.js call <SID>RunNpmCss()
augroup END

function! s:Trigger(cmd) abort
  echo "au triggers BufWritePost <buffer>" a:cmd
  exec "au triggers BufWritePost <buffer>" a:cmd
endfunction

command! -nargs=+ Trigger call <SID>Trigger(<q-args>)
