if exists("g:autoloaded_tmux") | finish | endif

let g:autoloaded_tmux = 1

function! tmux#getPanes(...) abort
  return join(keys(g:tmux_manifest), "\n")
endfunction

function! tmux#sendKeys(target, ...) abort
  let target = a:target
  let args = '"' . join(a:000, ' ') . '"'
  exec "silent! !tmux send -t" a:target args "Enter"
  redraw!
endfunction

function! tmux#create(cmd, args) abort
  exec "command! -nargs=1 -complete=custom,tmux#getPanes" a:cmd "call tmux#sendKeys(<f-args>, '" . a:args . "')"
endfunction
